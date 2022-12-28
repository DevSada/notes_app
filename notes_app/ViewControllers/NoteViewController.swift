//
//  NoteViewController.swift
//  notes_app
//
//  Created by Alexander Petrenko on 25.12.2022.
//

import UIKit




protocol NoteDelegate: AnyObject {
    func reloadAllNotesTable() 
}


class NoteViewController: UIViewController {
    
    
    var safeArea: UILayoutGuide!
    var noteTextView: UITextView!
    var noteType: NoteViewType!
    var noteIndex: Int!
    
    weak var noteDelegate: NoteDelegate?
    
    //   var noteText: String!
    // var noteStylesArray: [noteStyle] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        safeArea = view.safeAreaLayoutGuide
        self.view.translatesAutoresizingMaskIntoConstraints = false
        
        
        if noteType == .add {
            addNote(note: "")
            noteIndex = notesList.count - 1
        }
        
        noteTextView = getTextView()
        self.view.addSubview(noteTextView)
        noteTextView.becomeFirstResponder()
        NSLayoutConstraint.activate(getTextFieldContraints(to: noteTextView))
        
        noteTextView.delegate = self
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(updateTextView(notification:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(updateTextView(notification:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        if noteTextView.text == "" {
            removeNote(at: noteIndex)
        }
        noteDelegate?.reloadAllNotesTable()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.view.endEditing(true) //hiding keyboard for any object
    }
    
    private func getTextView() -> UITextView {
        let textView = UITextView(frame: .zero)
        textView.text = notesList[noteIndex]
        textView.backgroundColor = .white
        textView.textColor = .gray
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.sizeToFit()
        textView.dataDetectorTypes = UIDataDetectorTypes.all
        textView.autocapitalizationType = .sentences
        textView.autocorrectionType = .yes
        return textView
    }
    
    private func getTextFieldContraints(to textField: UITextView) -> [NSLayoutConstraint] {
        let constraints = [
            textField.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            textField.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16),
            textField.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 16),
            textField.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: 0)
        ]
        return constraints
    }
    
    @objc func updateTextView(notification: Notification) { // keyboard moving
        guard let userInfo = notification.userInfo as? [String: Any],
              let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
        else {
            return
        }
        
        if notification.name == UIResponder.keyboardWillHideNotification {
            noteTextView.contentInset = UIEdgeInsets.zero
        } else {
            noteTextView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardFrame.height, right: 0)
            noteTextView.scrollIndicatorInsets = noteTextView.contentInset
        }
        
        noteTextView.scrollRangeToVisible(noteTextView.selectedRange)
    }
    
    
}

extension NoteViewController: UITextViewDelegate {
    
    //    func textViewDidBeginEditing(_ textView: UITextView) {
    //        textView.backgroundColor = .white
    //        textView.textColor = .gray
    //    }
    //
    //    func textViewDidEndEditing(_ textView: UITextView) {
    //     //   saveNoteData()
    //    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        changeNote(at: noteIndex, change: noteTextView.text)
        return true
    }
}
