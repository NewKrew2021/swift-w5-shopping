//
//  ProductController.swift
//  StoreApp
//
//  Created by bean Milky on 2021/02/01.
//

import Foundation

class ProductController {
    private var productList: [ProductElement] = [ProductElement]()
    private let networkManager: NetworkManable = NetworkManager()

    init() {
        getBest()
        getGrocery()
        getFryingpan()
        getMask()
    }

    private func getBest() {
        ProductUseCase.getBest(with: networkManager) {
            (productList) in
            self.productList += productList ?? []
        }
    }

    private func getGrocery() {
        ProductUseCase.getGrocery(with: networkManager) {
            (productList) in
            self.productList += productList ?? []
        }
    }

    private func getFryingpan() {
        ProductUseCase.getFryingpan(with: networkManager) {
            (productList) in
            self.productList += productList ?? []
        }
    }

    private func getMask() {
        ProductUseCase.getMask(with: networkManager) {
            (productList) in
            self.productList += productList ?? []
        }
    }

    func findById(id: Int) -> ProductElement? {
        let filtered = productList.filter { $0.productId == id }
        guard filtered.count > 0 else { return nil }
        return filtered[0]
    }

    func get(index: Int) -> ProductElement {
        return productList[index]
    }

    func filteredProductList(with filter: String?=nil, limit: Int?=nil) -> [ProductElement] {
        let filtered = productList.filter { $0.contains(filter) }
        if let limit = limit {
            return Array(filtered.prefix(through: limit))
        } else {
            return filtered
        }
    }

    func filteredTvList(with filter: ProductElement.ProductType?=nil, limit: Int?=nil) -> [ProductElement] {
        let filtered = productList.filter { $0.type == (filter) }
        if let limit = limit {
            return Array(filtered.prefix(through: limit))
        } else {
            return filtered
        }
    }

}
