//
//  ProductUseCase.swift
//  StoreApp
//
//  Created by bean Milky on 2021/02/01.
//

import Foundation

struct ProductUseCase {
    static func getBest(with manager: NetworkManable, completed: @escaping ([ProductElement]?) -> Void) {
        try? manager.getResource(from: "/best.json") {
            (data, _) in
            if let tvData = data {
                let tvModels = try? JSONDecoder().decode([ProductElement].self, from: tvData)
                completed(tvModels)
            }
        }
    }
    static func getMask(with manager: NetworkManable, completed: @escaping ([ProductElement]?) -> Void) {
        try? manager.getResource(from: "/mask.json") {
            (data, _) in
            if let tvData = data {
                let tvModels = try? JSONDecoder().decode([ProductElement].self, from: tvData)
                completed(tvModels)
            }
        }
    }
    static func getGrocery(with manager: NetworkManable, completed: @escaping ([ProductElement]?) -> Void) {
        try? manager.getResource(from: "/grocery.json") {
            (data, _) in
            if let tvData = data {
                let tvModels = try? JSONDecoder().decode([ProductElement].self, from: tvData)
                completed(tvModels)
            }
        }
    }
    static func getFryingpan(with manager: NetworkManable, completed: @escaping ([ProductElement]?) -> Void) {
        try? manager.getResource(from: "/fryingpan.json") {
            (data, _) in
            if let tvData = data {
                let tvModels = try? JSONDecoder().decode([ProductElement].self, from: tvData)
                completed(tvModels)
            }
        }
    }
}
