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
            .subscribe(onNext: { pair in
                // to-do: handle click item
                print(pair)
            })
            .disposed(by: disposeBag)
        
        productController.items
            .bind(to: collectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }

}
