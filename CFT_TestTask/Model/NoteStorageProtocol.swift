//
//  NoteStorageProtocol.swift
//  CFT_TestTask
//
//  Created by Александр Мараенко on 22.02.2023.
//

import Foundation

protocol NoteStorageProtocol {
    func getNotesFromStorage() -> [Note]
    func getNoteFromStorageById(noteId: String) -> Note?
    // func setNotesToStorage(notesArray: [Note])
    func setOneNoteToStorage(note: Note)
    func deleteNoteFromStorageById(noteId: String)
    func movingNoteInStorage(sourceIndex: Int, destinationIndex: Int)

}
