//
//  Model.swift
//  notes_app
//
//  Created by Alexander Petrenko on 27.12.2022.
//

import UIKit

struct Note {
    var noteText: String
    var styleStart: Int
    var styleEnd: Int
    var styleFont: UIFont
}

enum NoteViewType: CaseIterable {
    case add, edit
}

var notesList = [String]()

func addNote(note: String) {
    notesList.append(note)
    
    saveNotesData()
}

func removeNote(at index: Int) {
    notesList.remove(at: index)
    saveNotesData()
}

func changeNote(at index: Int, change newNote: String) {
    notesList[index] = newNote
    saveNotesData()
}

func saveNotesData() {
    UserDefaults.standard.set(notesList, forKey: "notesList")
    UserDefaults.standard.synchronize()
}

func loadNotesData() {
    if let list = UserDefaults.standard.array(forKey: "notesList") as? [String] {
        notesList = list
    } else {
        notesList = []
    }
}

