//
//  NoteStorage.swift
//  CFT_TestTask
//
//  Created by Александр Мараенко on 03.02.2023.
//

import Foundation

enum FontSize: Int, Codable {
    case size_13 = 13
    case size_14 = 14
    case size_15 = 15
}

struct FontSet: Codable {
    
    var noteNameFontSize: FontSize
    var noteNameItalics: Bool
    var noteNameBold: Bool
    var noteTextFontSize: FontSize
    var noteTextItalics: Bool
    var noteTextBold: Bool
    
    init(noteNameFontSize: FontSize, noteNameItalics: Bool, noteNameBold: Bool, noteTextFontSize: FontSize, noteTextItalics: Bool, noteTextBold: Bool) {
        self.noteNameFontSize = noteNameFontSize
        self.noteNameItalics = noteNameItalics
        self.noteNameBold = noteNameBold
        self.noteTextFontSize = noteTextFontSize
        self.noteTextItalics = noteTextItalics
        self.noteTextBold = noteTextBold
    }
    
    init() {
        self.noteNameFontSize = .size_14
        self.noteNameItalics = false
        self.noteNameBold = false
        self.noteTextFontSize = .size_14
        self.noteTextItalics = false
        self.noteTextBold = false
    }
    
}

struct Note: Codable {
    
    var noteId: String
    var noteName: String
    var noteText: String
    var fontSet: FontSet
    var priority: Int

}


protocol NoteStorageProtocol {
    func getNotesFromStorage() -> [Note]
    func getNoteFromStorageById(noteId: String) -> Note?
    func setNotesToStorage(notesArray: [Note])
    func setOneNoteToStorage(note: Note)
    func deleteNoteFromStorageById(noteId: String)
    func movingNoteInStorage(sourceIndex: Int, destinationIndex: Int)

}

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
        print("не удалось выгрузмит даннык из userDefaults")
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
    
    func setNotesToStorage(notesArray: [Note]) {
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
