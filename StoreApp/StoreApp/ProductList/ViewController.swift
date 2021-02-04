//
//  ViewController.swift
//  StoreApp
//
//  Created by bean Milky on 2021/02/01.
//

import UIKit
import Toaster
import RxSwift

class ViewController: UIViewController {

    @IBOutlet var collectionView: UICollectionView!
    internal let disposeBag = DisposeBag()
    internal let productController: ProductController = ProductController()

    override func viewDidLoad() {
        super.viewDidLoad()
        setCollectionView()
        bindDataToCollectionView()
    }
    
    private func setCollectionView() {
        collectionView.register(UINib(nibName: "ProductCell", bundle: nil), forCellWithReuseIdentifier: ProductCell.identifier)
        collectionView.register(UINib(nibName: "ProductHeader", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ProductHeader.identifier)
        collectionView.delegate = self
    }

}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return UIDevice.current.orientation.isLandscape ? CGSize(width: collectionView.frame.width/2-20, height: collectionView.frame.width/2-20) : CGSize(width: collectionView.frame.width-20, height: collectionView.frame.width-20)
    }
}
