//
//  ProductUseCase.swift
//  StoreApp
//
//  Created by bean Milky on 2021/02/01.
//

import Foundation

struct ProductUseCase {
    static func getBest(with manager: NetworkManable, completed: @escaping ([ProductElement]?) -> Void) {
        try? manager.getResource(endPoint: EndPoint.baseUrl, from: "/best.json") {
            (data, _) in
            if let data = data {
                let product = try? JSONDecoder().decode([ProductElement].self, from: data)
                completed(product)
            }
        }
    }
    static func getMask(with manager: NetworkManable, completed: @escaping ([ProductElement]?) -> Void) {
        try? manager.getResource(endPoint: EndPoint.baseUrl, from: "/mask.json") {
            (data, _) in
            if let data = data {
                let product = try? JSONDecoder().decode([ProductElement].self, from: data)
                completed(product)
            }
        }
    }
    static func getGrocery(with manager: NetworkManable, completed: @escaping ([ProductElement]?) -> Void) {
        try? manager.getResource(endPoint: EndPoint.baseUrl, from: "/grocery.json") {
            (data, _) in
            if let data = data {
                let product = try? JSONDecoder().decode([ProductElement].self, from: data)
                completed(product)
            }
        }
    }
    static func getFryingpan(with manager: NetworkManable, completed: @escaping ([ProductElement]?) -> Void) {
        try? manager.getResource(endPoint: EndPoint.baseUrl, from: "/fryingpan.json") {
            (data, _) in
            if let data = data {
                let product = try? JSONDecoder().decode([ProductElement].self, from: data)
                completed(product)
            }
        }
    }
}
