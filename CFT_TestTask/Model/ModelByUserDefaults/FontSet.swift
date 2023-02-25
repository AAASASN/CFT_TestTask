//
//  FontSet.swift
//  CFT_TestTask
//
//  Created by Александр Мараенко on 22.02.2023.
//

import Foundation

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
