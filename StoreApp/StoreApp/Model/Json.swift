//
//  Json.swift
//  StoreApp
//
//  Created by 이청원 on 2021/02/02.
//

import UIKit

struct Json {
    func parsing(jsonData : Data) -> Request.Result<[Product], Error> {
        var products : [Product] = []
        let jsonDecoder: JSONDecoder = JSONDecoder()

        do {
            products = try jsonDecoder.decode([Product].self, from: jsonData)
            
            return .success(products)
        } catch let error {
            return .failure(error)
        }
    }
}
