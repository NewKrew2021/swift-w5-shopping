//
//  ProductCollcetionView.swift
//  StoreApp
//
//  Created by 윤준수 on 2021/02/01.
//

import UIKit

class ProductCollcetionViewUsecase: NSObject {
    var cellSize = CGSize()
    var productManager: ProductManager

    init(productManager: ProductManager) {
        self.productManager = productManager
    }

    func calculateSize(width: CGFloat?) {
        var width = (width ?? UIScreen.main.bounds.width) * 1
        var height: CGFloat
        if isPhone() {
            if UIDevice.current.orientation.isLandscape {
                width /= 2
            }
        } else {
            if UIDevice.current.orientation.isLandscape {
                width /= 3
            } else {
                width /= 2
            }
        }
        height = width * 1
        cellSize = CGSize(width: width, height: height)
    }

    func isPhone() -> Bool {
        return UIDevice.current.userInterfaceIdiom == .phone ? true : false
    }
}

extension ProductCollcetionViewUsecase: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in _: UICollectionView) -> Int {
        return 4
    }

    func collectionView(_: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productManager.getCount(productType: ProductType(rawValue: section) ?? .Best)
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind _: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header", for: indexPath)
        guard let header = headerView as? SectionHeader else { return headerView }
        header.setTitle(title: productManager.getSectionTitle(at: indexPath.section))
        return header
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        guard let productType = ProductType(rawValue: indexPath.section) else { return cell }
        guard let productCell = cell as? ProductCell, let product = productManager.getProduct(productType: productType, at: indexPath.item) else { return cell }
        productCell.setCell(product: product)
        DispatchQueue.global().async {
            NetworkHandler.getImage(url: product.productImage, title: product.title) { imageData in
                DispatchQueue.main.async {
                    productCell.setImage(image: UIImage(data: imageData))
                }
            }
        }
        return productCell
    }
}

extension ProductCollcetionViewUsecase: UICollectionViewDelegateFlowLayout {
    func collectionView(_: UICollectionView, layout _: UICollectionViewLayout, minimumLineSpacingForSectionAt _: Int) -> CGFloat {
        return 5
    }

    func collectionView(_: UICollectionView, layout _: UICollectionViewLayout, minimumInteritemSpacingForSectionAt _: Int) -> CGFloat {
        return 5
    }

    func collectionView(_: UICollectionView, layout _: UICollectionViewLayout, sizeForItemAt _: IndexPath) -> CGSize {
        return cellSize
    }
}
