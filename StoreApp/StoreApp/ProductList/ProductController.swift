//
//  ProductController.swift
//  StoreApp
//
//  Created by bean Milky on 2021/02/01.
//

import Foundation
import RxSwift
import RxCocoa
import RxDataSources

class ProductController {
    typealias Handler = ([ProductElement]) -> Void
    var items: BehaviorRelay<[SectionModel<String, ProductElement>]>
    private let networkManager: NetworkManable = NetworkManager()

    init() {
        items = BehaviorRelay<[SectionModel<String, ProductElement>]>(value: [])
        getBest(completed: nil)
        getGrocery(completed: nil)
        getFryingpan(completed: nil)
        getMask(completed: nil)
    }

    private func getBest(completed: Handler?) {
        ProductUseCase.getBest(with: networkManager) {
            (productList) in
            self.items.accept(self.items.value+[SectionModel(model: "BEST", items: productList ?? [])])
        }
    }

    private func getGrocery(completed: Handler?) {
        ProductUseCase.getGrocery(with: networkManager) {
            (productList) in
            self.items.accept(self.items.value+[SectionModel(model: "GROCERY", items: productList ?? [])])
        }
    }

    private func getFryingpan(completed: Handler?) {
        ProductUseCase.getFryingpan(with: networkManager) {
            (productList) in
            self.items.accept(self.items.value+[SectionModel(model: "FRYINGPAN", items: productList ?? [])])
        }
    }

    private func getMask(completed: Handler?) {
        ProductUseCase.getMask(with: networkManager) {
            (productList) in
            self.items.accept(self.items.value+[SectionModel(model: "MASK", items: productList ?? [])])
        }
    }

}
