//
//  AllNotesViewController.swift
//  notes_app
//
//  Created by Alexander Petrenko on 26.12.2022.
//

import UIKit

class AllNotesViewController: UIViewController {
    
    var safeArea: UILayoutGuide!
    var allNotesCollectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadNotesData()

        safeArea = view.safeAreaLayoutGuide
        self.view.translatesAutoresizingMaskIntoConstraints = false
        
        allNotesCollectionView = getCollectionView()
        self.view.addSubview(allNotesCollectionView)
        NSLayoutConstraint.activate(getCollectionViewContraints(to: allNotesCollectionView))
        
    }
    
    private func getCollectionView() -> UICollectionView{
        let colView = UICollectionView(frame: .zero)
        return colView
        
    }
    
    private func getCollectionViewContraints(to collectionView: UICollectionView) -> [NSLayoutConstraint] {
        let constraints = [
            collectionView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            collectionView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16),
            collectionView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 0),
            collectionView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: 0)
        ]
        return constraints
    }
    
    private func saveNotesData() {
        
    }
    
    private func loadNotesData() {
        
    }

}
