//
//  ProductManager.swift
//  StoreApp
//
//  Created by 윤준수 on 2021/02/02.
//

import Foundation

class ProductManager {
    static let instance = ProductManager()

    private var products: [ProductType: [Product]]

    private init() {
        products = [:]
    }

    func setProducts(productType: ProductType, products: [Product]) {
        print(self.products)
        self.products[productType] = products
    }

    func getProduct(productType: ProductType, at: Int) -> Product? {
        guard let product = products[productType]?[at] else { return nil }
        return product
    }

    func getCount(productType: ProductType) -> Int {
        return products[productType]?.count ?? 0
    }
}

enum ProductType: Int, CaseIterable {
    case Best = 0
    case Mask = 1
    case Grocery = 2
    case Flyingpan = 3
}
