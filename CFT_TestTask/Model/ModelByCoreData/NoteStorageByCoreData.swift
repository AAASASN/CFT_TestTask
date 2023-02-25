//
//  NoteStorageByCoreData.swift
//  CFT_TestTask
//
//  Created by Александр Мараенко on 25.02.2023.
//

import Foundation
import CoreData

class NoteStorageByCoreData {
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CFT_TestTask")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    // init заглушка для первого запуска
    init() {
        
        // создадим запрос на извлечение
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "EntityForCoreData")
        
        // настроим его предикат
        // fetchRequest.predicate = NSPredicate(format: "labelText = someText")
        
        // извлекаеи контекст
        let context = persistentContainer.viewContext
        
        // получаем данные в виде массива из контектста посредством метода .fetch(fetchRequest)
        if let dataArray = try? context.fetch(fetchRequest) as? [EntityForCoreData], dataArray.isEmpty {
            print("!!!!!!!!!!!!!!")
            print(dataArray.count)
            let fontSet = FontSet(noteNameFontSize: .size_14,
                                  noteNameItalics: false,
                                  noteNameBold: false,
                                  noteTextFontSize: .size_14,
                                  noteTextItalics: false,
                                  noteTextBold: false)
            
            let note = Note(noteId: "1234567890",
                            noteName: "Создайте заметку",
                            noteText: "для создания тапните по этой ячейке или нажмите кнопку плюс в правом верхнем углу экрана",
                            fontSet: fontSet,
                            priority: 1)
            
            let notesArray = [note]
            
            let encoder = JSONEncoder()
                    
            let notesArrayAsData = try? encoder.encode(notesArray)
            
            let entityForCoreData = EntityForCoreData(context: context)
            
            entityForCoreData.noteArrayAsData = notesArrayAsData
            try? context.save()
            
        } 
    }
    
}



extension NoteStorageByCoreData: NoteStorageProtocol {
        
    
    // MARK: - getNotesFromStorage()
    func getNotesFromStorage() -> [Note] {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "EntityForCoreData")
        
        let context = persistentContainer.viewContext
        
        if let dataArray = try? context.fetch(fetchRequest) as? [EntityForCoreData], !dataArray.isEmpty {
            let decoder = JSONDecoder()
            if let dataFromDataArray = dataArray.first?.noteArrayAsData {
                if let arrayForReturn = try? decoder.decode([Note].self, from: dataFromDataArray) {
                    return arrayForReturn
                }
            }
        }
        print("не удалось выгрузить данные из CoreData или массив пустой")
        return []
    }
    
    // MARK: - setNotesToStorage
    func setNotesToStorage(notesArray: [Note]) {

        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "EntityForCoreData")
        
        let context = persistentContainer.viewContext
        
        if let dataArray = try? context.fetch(fetchRequest) as? [EntityForCoreData], !dataArray.isEmpty {
            if let entityForDeleting = dataArray.first {
                let encoder = JSONEncoder()
                let notesArrayAsData = try? encoder.encode(notesArray)
                entityForDeleting.noteArrayAsData = notesArrayAsData
                try? context.save()
            }
        }
    }
    
    
    
    // MARK: - getNoteFromStorageById
    func getNoteFromStorageById(noteId: String) -> Note? {
        
        var noteForReturn = Note(noteId: "error",
                                 noteName: "error",
                                 noteText: "error",
                                 fontSet: FontSet(),
                                 priority: 1)
        
        let noteArray = getNotesFromStorage()
        for note in noteArray{
            if noteId == note.noteId {
                noteForReturn = note
            }
        }
        return noteForReturn
    }
    
    // MARK: - setOneNoteToStorage()
    func setOneNoteToStorage(note: Note) {
        let noteArray = getNotesFromStorage()
        var newNoteArray = [Note]()
        for oneNote in noteArray{
            if note.noteId != oneNote.noteId {
                newNoteArray.append(oneNote)
            }
        }
        newNoteArray.append(note)
        setNotesToStorage(notesArray: newNoteArray)
    }
    
    // MARK: - deleteNoteFromStorageById
    func deleteNoteFromStorageById(noteId: String) {
        let noteArray = getNotesFromStorage()
        var newNoteArray = [Note]()
        for oneNote in noteArray{
            if noteId != oneNote.noteId {
                newNoteArray.append(oneNote)
            }
        }
        setNotesToStorage(notesArray: newNoteArray)
    }
    
    // MARK: - movingNoteInStorage
    func movingNoteInStorage(sourceIndex: Int, destinationIndex: Int) {
        var notesArray = getNotesFromStorage()
        let noteMoving = notesArray.remove(at: sourceIndex)
        notesArray.insert(noteMoving, at: destinationIndex)
        
        setNotesToStorage(notesArray: notesArray)
    }

}
