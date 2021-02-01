//
//  ViewController.swift
//  StoreApp
//
//  Created by 윤준수 on 2021/02/01.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var shoppingCollectionView: UICollectionView!
    var collectionView: ProductCollcetionView = ProductCollcetionView()
    override func viewDidLoad() {
        super.viewDidLoad()
        shoppingCollectionView.delegate = collectionView
        shoppingCollectionView.dataSource = collectionView
    }


}

//extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 3
//    }
//    
//    collce
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        <#code#>
//    }
//    
//    
//}
