//
//  Model.swift
//  notes_app
//
//  Created by Alexander Petrenko on 27.12.2022.
//

import UIKit

struct Note {
    var noteText: String
    var noteStyle: [NoteStyle]?
}

struct NoteStyle {
    var styleStart: Int
    var styleEnd: Int
    var styleFont: UIFont // bold italic underline
}

struct AppFontName {
    static let regular = "CourierNewPSMT"
    static let bold = "CourierNewPS-BoldMT"
    static let italic = "CourierNewPS-ItalicMT"
}

enum NoteViewType: CaseIterable {
    case add, edit
}

var notesList = [Note]()

let italicFont = [
    NSAttributedString.Key.font : UIFont.init(name: AppFontName.italic, size: 14),
    NSAttributedString.Key.foregroundColor : UIColor.gray
]




