//
//  ProductUseCase.swift
//  StoreApp
//
//  Created by bean Milky on 2021/02/01.
//

import UIKit

struct ProductUseCase {
    static func getBest(with manager: NetworkManable, completed: @escaping ([Product]) -> Void) {
        try? manager.getResource(endPoint: EndPoint.baseUrl, from: "/best.json") {
            (data, _) in
            if let data = data {
                let productElements = try? JSONDecoder().decode([ProductElement].self, from: data)
                ProductUseCase.processProduct(with: manager, productElements: productElements ?? [], type: Product.ProductType.BEST) {
                    products in
                    completed(products)
                }
            }
        }
    }
    static func getMask(with manager: NetworkManable, completed: @escaping ([Product]) -> Void) {
        try? manager.getResource(endPoint: EndPoint.baseUrl, from: "/mask.json") {
            (data, _) in
            if let data = data {
                let productElements = try? JSONDecoder().decode([ProductElement].self, from: data)
                ProductUseCase.processProduct(with: manager, productElements: productElements ?? [], type: Product.ProductType.MASK) {
                    products in
                    completed(products)
                }
            }
        }
    }
    static func getGrocery(with manager: NetworkManable, completed: @escaping ([Product]) -> Void) {
        try? manager.getResource(endPoint: EndPoint.baseUrl, from: "/grocery.json") {
            (data, _) in
            if let data = data {
                let productElements = try? JSONDecoder().decode([ProductElement].self, from: data)
                ProductUseCase.processProduct(with: manager, productElements: productElements ?? [], type: Product.ProductType.GROCERY) {
                    products in
                    completed(products)
                }
            }
        }
    }
    static func getFryingpan(with manager: NetworkManable, completed: @escaping ([Product]) -> Void) {
        try? manager.getResource(endPoint: EndPoint.baseUrl, from: "/fryingpan.json") {
            (data, _) in
            if let data = data {
                let productElements = try? JSONDecoder().decode([ProductElement].self, from: data)
                ProductUseCase.processProduct(with: manager, productElements: productElements ?? [], type: Product.ProductType.FRYINGPAN) {
                    products in
                    completed(products)
                }
            }
        }
    }
    
    static private func processProduct(with manager: NetworkManable, productElements: [ProductElement], type: Product.ProductType, completed: @escaping ([Product]) -> Void) {
        completed(productElements.map {
            productElement in
            
            let product = Product(productElement: productElement, type: type)
            do {
                try manager.download(from: productElement.productImage) {
                    imageData, error in
                    guard error == nil else { return }
                    if let data = imageData {
                        product.setImage(image: UIImage(data: data))
                    }
                }
            } catch {
                product.setImage(image: UIImage(named: "default"))
            }
            return product
        })
    }
}
