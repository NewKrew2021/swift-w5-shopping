//
//  ViewControllerBinding.swift
//  StoreApp
//
//  Created by bean Milky on 2021/02/02.
//

import Foundation
import RxSwift
import RxCocoa

extension ViewController {

    func bindDataToCollectionView() {
        let items = productController.productList!
        items
            .bind(to: collectionView.rx.items(cellIdentifier: cellReuseIdentifier, cellType: ProductCell.self)) {sequence, element, cell in
                cell.backgroundColor = .cyan
                cell.config(viewModel: ProductCellViewModel(product: element))
        }
            .disposed(by: disposeBag)
    }

}
