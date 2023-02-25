//
//  NoteStorage.swift
//  CFT_TestTask
//
//  Created by Александр Мараенко on 03.02.2023.
//

import Foundation


struct NoteStorage: NoteStorageProtocol {

    // init заглушка для первого запуска
    init() {
        
        let firstArrayResponse = getNotesFromStorage()
        
        if firstArrayResponse.isEmpty {
            
            let tempNotesArray = [Note(noteId: "1234567890",
                                       noteName: "Создайте заметку",
                                       noteText: "для создания тапните по этой ячейке или нажмите кнопку плюс в правом верхнем углу экрана",
                                       fontSet: FontSet(),
                                       priority: 1)]
            
            setNotesToStorage(notesArray: tempNotesArray)
            
        }

    }
        
    // enum для хранения ключей для работы с userDefaults
    enum enumForStoreKeys: String {
        case UDKey
    }
    
    // userDefaults
    fileprivate var userDefaults = UserDefaults.standard
    
    func getNotesFromStorage() -> [Note] {
        
        // вытащим из userDefaults объект типа Data и конвертируем его в [Note] при помощи возможностей JSONDecoder()
        if let dataFromUserDefaults = userDefaults.object(forKey: enumForStoreKeys.UDKey.rawValue) as? Data {
            
            let decoder = JSONDecoder()
            
            if let noteArray = try? decoder.decode([Note].self, from: dataFromUserDefaults) {
                return noteArray
            }
            
        }
        print("не удалось выгрузить данные из userDefaults")
        return []
    }
    
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
    
    internal func setNotesToStorage(notesArray: [Note]) {
        // создаем экземпляр JSONEncoder()
        let encoder = JSONEncoder()
                
        // и с его помощью преобразуем данные для сохранения в userDefaults к типу Data
        let notesArrayAsData = try? encoder.encode(notesArray.sorted {
            
            // сортировка по приоритету - пока не реализовано отображение в таблице
            $0.priority < $1.priority
            
        })
        
        // засовываем эти данные в userDefaults по ключу
        userDefaults.set(notesArrayAsData, forKey: enumForStoreKeys.UDKey.rawValue)
    }
    
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
    
    
    func movingNoteInStorage(sourceIndex: Int, destinationIndex: Int) {
        
        var notesArray = getNotesFromStorage()
        let noteMoving = notesArray.remove(at: sourceIndex)
        notesArray.insert(noteMoving, at: destinationIndex)
        
        setNotesToStorage(notesArray: notesArray)
        
    }
    
}
