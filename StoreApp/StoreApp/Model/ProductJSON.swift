//
//  ProductJSON.swift
//  StoreApp
//
//  Created by 윤준수 on 2021/02/01.
//

import Foundation

struct ProductJSON: Decodable {
    var storeDomain, productName, productImage: String
    var productId: Int // UUID 가능?
    var originalPrice: Int
    var groupDiscountUserCount, groupDiscountedPrice: Int?
}
