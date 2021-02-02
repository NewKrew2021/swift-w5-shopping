//
//  ProductController.swift
//  StoreApp
//
//  Created by bean Milky on 2021/02/01.
//

import Foundation
import RxSwift

class ProductController {
    typealias Handler = ([ProductElement]) -> Void

    let productList: PublishSubject<[ProductElement]>!
    private let networkManager: NetworkManable = NetworkManager()

    init() {
        productList = PublishSubject<[ProductElement]>()
        getBest(completed: nil)
        getGrocery(completed: nil)
        getFryingpan(completed: nil)
        getMask(completed: nil)
    }

    private func getBest(completed: Handler?) {
        ProductUseCase.getBest(with: networkManager) {
            (productList) in
            self.productList.onNext(productList ?? [])
        }
    }

    private func getGrocery(completed: Handler?) {
        ProductUseCase.getGrocery(with: networkManager) {
            (productList) in
            self.productList.onNext(productList ?? [])
        }
    }

    private func getFryingpan(completed: Handler?) {
        ProductUseCase.getFryingpan(with: networkManager) {
            (productList) in
            self.productList.onNext(productList ?? [])
        }
    }

    private func getMask(completed: Handler?) {
        ProductUseCase.getMask(with: networkManager) {
            (productList) in
            self.productList.onNext(productList ?? [])
        }
    }

}
