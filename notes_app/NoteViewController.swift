//
//  NoteViewController.swift
//  notes_app
//
//  Created by Alexander Petrenko on 25.12.2022.
//

import UIKit

class NoteViewController: UIViewController {

    
    var safeArea: UILayoutGuide!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        safeArea = view.safeAreaLayoutGuide
        
        self.view.translatesAutoresizingMaskIntoConstraints = false
        
        let textView = getTextView()
        
        self.view.addSubview(textView)
        NSLayoutConstraint.activate(getTextFieldContraints(to: textView))
        
    }
    
    private func getTextView() -> UITextView {
        let textView = UITextView(frame: .zero)
        textView.text = "adasdsadasd as dsad sad sad as das dasd asd asd asd asd sad sa dadqwdeqwdeqwc asd asd adqe aed aadasd asd d qad a caw caw cxas xcsadadaw caw cac acs"
        textView.backgroundColor = .blue

        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.sizeToFit()

        return textView
    }

    private func getTextFieldContraints(to textField: UITextView) -> [NSLayoutConstraint] {
        let constraint = [
            textField.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            textField.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16),
            textField.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 0),
            textField.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: 0)
        ]
        return constraint
    }
  

}
