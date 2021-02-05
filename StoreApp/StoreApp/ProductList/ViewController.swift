//
//  ViewController.swift
//  StoreApp
//
//  Created by bean Milky on 2021/02/01.
//

import UIKit
import Toaster
import RxSwift
import RxCocoa
import RxDataSources

class ViewController: UIViewController {

    @IBOutlet var collectionView: UICollectionView!
    private let disposeBag = DisposeBag()
    private let productController: ProductController = ProductController()
    private var selectedProduct: Product?

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

extension ViewController {

    func bindDataToCollectionView() {
        let dataSource = RxCollectionViewSectionedReloadDataSource<SectionModel<String, Product>>(
            configureCell: { (_, collectionView, indexPath, element) in
                if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCell.identifier, for: indexPath) as? ProductCell {
                    cell.configure(viewModel: ProductCellViewModel(product: element))
                    return cell
                }
                return ProductCell()
            },
            configureSupplementaryView: { (dataSource, collectionView, kind, indexPath) -> UICollectionReusableView in
                if let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: ProductHeader.identifier, for: indexPath) as? ProductHeader {
                    header.configure(title: dataSource[indexPath.section].model)
                    return header
                }
                return UICollectionReusableView()
            })

        collectionView.rx
            .itemSelected
            .map { indexPath in
                return (indexPath, dataSource[indexPath])
            }
            .subscribe(onNext: { [weak self] pair in
                let (_, product) = pair
                self?.selectedProduct = product.copy() as? Product
                self?.performSegue(withIdentifier: "goToDetail", sender: self)
            })
            .disposed(by: disposeBag)

        productController.items
            .bind(to: collectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToDetail" {
            if let destinationVC = segue.destination as? ProductDetailViewController {
                destinationVC.setProduct(product: selectedProduct)
            }
        }
    }
}
