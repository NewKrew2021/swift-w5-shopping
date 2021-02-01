//
//  ViewController.swift
//  StoreApp
//
//  Created by 이청원 on 2021/02/01.
//

import UIKit

class ViewController: UIViewController {
    
    let collectionView: UICollectionView = {
        let view = UICollectionView.init(frame: .init(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: UICollectionViewFlowLayout())
        view.register(UINib(nibName: "ShoppingCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "shoppingCollectionViewCell")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addCollectionView()
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func addCollectionView() {
        self.view.addSubview(collectionView)
        self.collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        self.collectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        self.collectionView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        self.collectionView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
    }
}

extension ViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return 1
        }

        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "shoppingCollectionViewCell", for: indexPath)

            return cell
        }
}
