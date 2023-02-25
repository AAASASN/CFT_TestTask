//
//  Note.swift
//  CFT_TestTask
//
//  Created by Александр Мараенко on 25.02.2023.
//

import Foundation

struct Note: Codable {
    
    var noteId: String
    var noteName: String
    var noteText: String
    var fontSet: FontSet
    var priority: Int

}
