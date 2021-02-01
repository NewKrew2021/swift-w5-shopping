//
//  ViewController.swift
//  StoreApp
//
//  Created by bean Milky on 2021/02/01.
//

import UIKit
import Toaster

class ViewController: UIViewController, UICollectionViewDelegate {

    @IBOutlet var collectionView: UICollectionView!
    let productController: ProductController = ProductController()
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true

        // to-do: will be divided into other class
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .green
        collectionView.register(UINib(nibName: "ProductCell", bundle: nil), forCellWithReuseIdentifier: "ProductCell")

        let screenWidht = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.minimumLineSpacing = 10
        layout.estimatedItemSize = CGSize(width: screenWidht, height: screenHeight/2.5)
        collectionView.collectionViewLayout = layout

    }

}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as? ProductCell {
            cell.backgroundColor = .cyan
            return cell
        }
        return UICollectionViewCell()
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return UIDevice.current.orientation.isPortrait ? CGSize(width: collectionView.frame.width-20, height: collectionView.frame.width-20)
        : CGSize(width: collectionView.frame.width/2-20, height: collectionView.frame.width/2-20)
    }
}
