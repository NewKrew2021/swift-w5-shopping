//
//  ViewController.swift
//  StoreApp
//
//  Created by 윤준수 on 2021/02/01.
//

import UIKit

class MainViewController: UIViewController {
    @IBOutlet var shoppingCollectionView: UICollectionView!
    private let productManager = ProductManager.instance
    lazy var productCollectionView = ProductCollcetionView(productManager: productManager)

    override func viewDidLoad() {
        super.viewDidLoad()
        productCollectionView.calculateSize(width: nil)
        productCollectionView.productManager = productManager
        shoppingCollectionView.delegate = productCollectionView
        shoppingCollectionView.dataSource = productCollectionView

        NetworkHandler.delegate = self
        for type in ProductType.allCases {
            DispatchQueue.global().async {
                NetworkHandler.getData(productType: type)
            }
        }
    }
}

extension MainViewController: NetworkHandlerDelegate {
    func saveProducts(productType: ProductType, products: [Product]) {
        DispatchQueue.main.async {
            self.productManager.setProducts(productType: productType, products: products)
        }

        DispatchQueue.main.async {
            self.shoppingCollectionView.reloadSections(IndexSet(integer: productType.rawValue))
        }
    }
}
