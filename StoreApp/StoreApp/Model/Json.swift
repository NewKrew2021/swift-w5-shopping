//
//  Json.swift
//  StoreApp
//
//  Created by 이청원 on 2021/02/02.
//

import UIKit

struct Json {
    func parsing(jsonData : Data, productType : ProductType) {
        var products : [Product] = []
        let jsonDecoder: JSONDecoder = JSONDecoder()

        do {
            products = try jsonDecoder.decode([Product].self, from: jsonData)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "jsonParsing"),object: nil, userInfo: ["products" : products, "productTypeValue" : productType.rawValue])
        } catch let error {
            print("error: ", error)
        }
    }
}
