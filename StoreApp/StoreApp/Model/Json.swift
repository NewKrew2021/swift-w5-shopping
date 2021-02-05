//
//  Json.swift
//  StoreApp
//
//  Created by 이청원 on 2021/02/02.
//

import UIKit

struct Json {
    func parsingProduct(jsonData : Data) -> Request.Result<[Product], Error> {
        var products : [Product] = []
        let jsonDecoder: JSONDecoder = JSONDecoder()

        do {
            products = try jsonDecoder.decode([Product].self, from: jsonData)
            
            return .success(products)
        } catch let error {
            return .failure(error)
        }
    }
    
    func parsingProductDetail(jsonData : Data) ->Request.Result<ProductDetail, Error> {
        let jsonDecoder: JSONDecoder = JSONDecoder()
        do {
            let jsonString = String(decoding: jsonData, as: UTF8.self).replacingOccurrences(of: "\\u", with: "").replacingOccurrences(of: "\\\"", with: "")
            let productDetail = try jsonDecoder.decode(ProductDetail.self, from: jsonString.data(using: .utf8) ?? Data())
            
            return .success(productDetail)
        } catch let error {
            return .failure(error)
        }
    }
}
