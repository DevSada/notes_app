//
//  DataManager.swift
//  notes_app
//
//  Created by Alexander Petrenko on 28.12.2022.
//

import Foundation

func addNote(note: Note) {
    notesList.append(note)
    saveNotesData()
}

func removeNote(at index: Int) {
    notesList.remove(at: index)
    saveNotesData()
}

func changeNote(at index: Int, change newNoteText: String) {
    notesList[index].noteText = newNoteText
    saveNotesData()
}

func getTextNote(at index: Int) -> String {
    var str = " sdfsd fdsf dsf dsf sdf sf sd s w332332 32 e23e23d 23d 23 2"
    //notesList[index]
    for charater in str {
        print(charater)
    }
    
    var attributedString1 = NSMutableAttributedString(string:"STARTED\n", attributes: italicFont)
    
    // 0....14 14.....23(italic) 23-45(standrt) 45.....87(bold)
    return str
}

func saveNotesData() {
    UserDefaults.standard.set(notesList, forKey: "notesList")
    UserDefaults.standard.synchronize()
}

func loadNotesData() {
    if let list = UserDefaults.standard.array(forKey: "notesList") as? [Note] {
        notesList = list
    } else {
        notesList = []
    }
}
