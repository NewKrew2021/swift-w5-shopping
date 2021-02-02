//
//  ViewController.swift
//  StoreApp
//
//  Created by bean Milky on 2021/02/01.
//

import UIKit
import Toaster
import RxSwift

class ViewController: UIViewController, UICollectionViewDelegate {

    @IBOutlet var collectionView: UICollectionView!
    let cellReuseIdentifier = "ProductCell"
    let disposeBag = DisposeBag()
    let productController: ProductController = ProductController()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true

        // to-do: will be divided into other class
        collectionView.backgroundColor = .green
        collectionView.register(UINib(nibName: "ProductCell", bundle: nil), forCellWithReuseIdentifier: cellReuseIdentifier)

        let screenWidht = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.estimatedItemSize = CGSize(width: screenWidht, height: screenHeight/2.5)
        collectionView.collectionViewLayout = layout

        bindDataToCollectionView()
    }

}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return UIDevice.current.orientation.isPortrait ? CGSize(width: collectionView.frame.width-20, height: collectionView.frame.width-20)
        : CGSize(width: collectionView.frame.width/2-20, height: collectionView.frame.width/2-20)
    }
}
