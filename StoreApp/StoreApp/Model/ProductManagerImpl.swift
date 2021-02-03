//
//  ProductManager.swift
//  StoreApp
//
//  Created by 윤준수 on 2021/02/02.
//

import Foundation

protocol ProductManager {
    func requestAllData()
    func getSectionTitle(at: Int) -> String
    func setProducts(productType: ProductType, products: [Product])
    func getProduct(productType: ProductType, at: Int) -> Product?
    func getCount(productType: ProductType) -> Int
}

class ProductManagerImpl: ProductManager, NetworkHandlerDelegate {
    static let instance = ProductManagerImpl()
    let sectionTitle = ["베스트", "마스크", "잡화", "프라이팬"]
    private var products: [ProductType: [Product]] = [:]

    private init() {
        for type in ProductType.allCases {
            products[type] = []
        }
        NetworkHandler.delegate = self
        requestAllData()
    }

    func requestAllData() {
        for type in ProductType.allCases {
            DispatchQueue.global().async {
                NetworkHandler.getData(productType: type)
            }
        }
    }

    func getSectionTitle(at: Int) -> String {
        return sectionTitle[at]
    }

    func saveProducts(productType: ProductType, products: [Product]) {
        DispatchQueue.main.async {
            self.products[productType] = products
            NotificationCenter.default.post(name: NSNotification.Name("reloadSection"), object: nil, userInfo: ["at": productType.rawValue])
        }
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
    case Mask
    case Grocery
    case Flyingpan
}
