//
//  ProductCollcetionView.swift
//  StoreApp
//
//  Created by 윤준수 on 2021/02/01.
//

import UIKit

class ProductCollcetionView: NSObject {
    var cellSize = CGSize()

    func calculateSize(width: CGFloat?) {
        var width = (width ?? UIScreen.main.bounds.width) * 0.8
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
        height = width * 1.2
        cellSize = CGSize(width: width, height: height)
    }

    func isPhone() -> Bool {
        return UIDevice.current.userInterfaceIdiom == .phone ? true : false
    }
}

extension ProductCollcetionView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        return 8
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind _: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header", for: indexPath)
        guard let header = headerView as? SectionHeader else { return headerView }
        header.backgroundColor = .blue
        header.setTitle(title: "베스트")
        return header
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        cell.backgroundColor = .brown

        guard let productCell = cell as? ProductCell else { return cell }
        let product = Product(imageUrl: "vod01", title: "title", price: 00, participant: 00)
        productCell.setCell(product: product)
        return productCell
    }
}

extension ProductCollcetionView: UICollectionViewDelegateFlowLayout {
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
