//
//  ViewControllerBinding.swift
//  StoreApp
//
//  Created by bean Milky on 2021/02/02.
//

import Foundation
import RxSwift
import RxCocoa
import RxDataSources

extension ViewController {

    func bindDataToCollectionView() {
        let dataSource = RxCollectionViewSectionedReloadDataSource<SectionModel<String, ProductElement>>(
            configureCell: { (_, collectionView, indexPath, element) in
                if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCell.identifier, for: indexPath) as? ProductCell {
                    cell.backgroundColor = .cyan
                    cell.config(viewModel: ProductCellViewModel(product: element))
                    return cell
                }
                return ProductCell()
            },
            configureSupplementaryView: { (dataSource, collectionView, kind, indexPath) -> UICollectionReusableView in
                if let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: ProductHeader.identifier, for: indexPath) as? ProductHeader {
                    return header
                }
                return UICollectionReusableView()
            })
        
        productController.items
            .bind(to: collectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
    }

}
