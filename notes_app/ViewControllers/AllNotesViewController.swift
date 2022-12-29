//
//  AllNotesViewController.swift
//  notes_app
//
//  Created by Alexander Petrenko on 26.12.2022.
//

import UIKit

class AllNotesViewController: UIViewController {
    
    var safeArea: UILayoutGuide!
    var allNotesTableView: UITableView!
    var addButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var str = " sdfsd fdsf dsf dsf sdf sf sd s w332332 32 e23e23d 23d 23 2"
        //notesList[index]
        var charPosition = 0
        for char in str {
            charPosition += 1
            print(char)
        }
        
        safeArea = view.safeAreaLayoutGuide
        self.view.translatesAutoresizingMaskIntoConstraints = false
        
        addButton = getAddButton()
        self.view.addSubview(addButton)
        NSLayoutConstraint.activate(getButtonContraints(to: addButton))
        
        allNotesTableView = getTableView()
        self.view.addSubview(allNotesTableView)
        NSLayoutConstraint.activate(getTableViewContraints(to: allNotesTableView))
        
        allNotesTableView.register(UITableViewCell.self, forCellReuseIdentifier: "noteCell")
        allNotesTableView.delegate = self
        allNotesTableView.dataSource = self
        
    }
    
    private func getTableView() -> UITableView{
        let tableView = UITableView(frame: .zero)
        tableView.backgroundColor = .blue
        tableView.layer.cornerRadius = 10
        tableView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }
    
    private func getAddButton() -> UIButton {
        let addButton = UIButton(frame: .zero)
        addButton.setTitle("add new note", for: .normal)
        addButton.setTitleColor(.black, for: .normal)
        addButton.backgroundColor = .systemPink
        addButton.layer.cornerRadius = 10
        addButton.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        addButton.addTarget(self, action: #selector(buttonPressed) , for: .touchUpInside)
        addButton.translatesAutoresizingMaskIntoConstraints = false
        return addButton
    }
    
    private func getButtonContraints(to button: UIButton) -> [NSLayoutConstraint] {
        let constraints = [
            button.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            button.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16),
            button.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 10),
            button.heightAnchor.constraint(equalToConstant: 35)
        ]
        return constraints
    }
    
    private func getTableViewContraints(to tableView: UITableView) -> [NSLayoutConstraint] {
        let constraints = [
            tableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16),
            tableView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 45),
            tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -20)
        ]
        return constraints
    }
    
    @objc func buttonPressed() {
        showEditNote(as: .add, with: nil)
    }
    
    @objc func cellTap(_ sender: UITapGestureRecognizer) {
        let location = sender.location(in: self.allNotesTableView)
        let indexPath = self.allNotesTableView.indexPathForRow(at: location)
        showEditNote(as: .edit, with: indexPath?.row)
    }
    
    func showEditNote(as noteType: NoteViewType, with index: Int?) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let noteViewController = storyBoard.instantiateViewController(withIdentifier: "noteViewController") as! NoteViewController
        noteViewController.noteDelegate = self
        noteViewController.noteIndex = index
        noteViewController.noteType = noteType
        self.present(noteViewController, animated: true, completion: nil)
    }
    
}

extension AllNotesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = allNotesTableView.dequeueReusableCell(withIdentifier: "noteCell", for: indexPath)
        cell.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(cellTap)))
        cell.textLabel?.text = notesList[indexPath.row].noteText
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if commit == .delete {
            removeNote(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
}

extension AllNotesViewController: NoteDelegate {
    func reloadAllNotesTable() {
        allNotesTableView.reloadData()
    }
}
