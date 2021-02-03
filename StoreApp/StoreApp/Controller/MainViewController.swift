//
//  ViewController.swift
//  StoreApp
//
//  Created by 윤준수 on 2021/02/01.
//

import UIKit

class MainViewController: UIViewController {
    @IBOutlet var shoppingCollectionView: UICollectionView!
    private let productManager = ProductManagerImpl.instance
    lazy var productCollectionView = ProductCollcetionViewUsecase(productManager: productManager)

    override func viewDidLoad() {
        super.viewDidLoad()
        productCollectionView.calculateSize(width: nil)
        productCollectionView.productManager = productManager
        shoppingCollectionView.delegate = productCollectionView
        shoppingCollectionView.dataSource = productCollectionView

        let fm = FileManager()
        print(fm.currentDirectoryPath)

        NotificationCenter.default.addObserver(self, selector: #selector(reloadSection(_:)), name: NSNotification.Name("reloadSection"), object: nil)
    }

    @objc func reloadSection(_ noticiation: Notification) {
        guard let index = noticiation.userInfo?["at"] as? Int else { return }
        shoppingCollectionView.reloadSections(IndexSet(integer: index))
    }
}
