//
//  DataManager.swift
//  notes_app
//
//  Created by Alexander Petrenko on 28.12.2022.
//

import Foundation

func addNote(note: String) {
    notesList.append(note)
    saveNotesData()
}

func removeNote(at index: Int) {
    notesList.remove(at: index)
    saveNotesData()
}

func changeNote(at index: Int, change newNoteText: String) {
    notesList[index] = newNoteText
    saveNotesData()
}

//func changeChar(in stringIndex: Int, at charIndex: Int, change char: String, with attributes: NSAttributedString.Key){
//    notesList[stringIndex].noteByChar[charIndex].char = NSMutableAttributedString(string: char, attributes: attributes)
//
//}

//func getTextNote(at index: Int) -> String {
//    var str = " sdfsd fdsf dsf dsf sdf sf sd s w332332 32 e23e23d 23d 23 2" // notesList[index].noteText
//    for charater in str {
//        print(charater)
//        var attributedString1 = NSMutableAttributedString(string: charater, attributes: italicFont)
//        attributedString1.append(attributedString2)
//    }
//    // 0....14 14.....23(italic) 23-45(standrt) 45.....87(bold)
//    return str
//}

func saveNotesData() {
  
//    var userDefaults = UserDefaults.standard
//    let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: notesList)
//    userDefaults.set(encodedData, forKey: "noteList")
    UserDefaults.standard.set(notesList, forKey: "notesList")
    UserDefaults.standard.synchronize()
    
}

func loadNotesData() {
    if let list = UserDefaults.standard.array(forKey: "noteList") as? [String] {
        notesList = list
    } else {
        notesList = []
    }
}
