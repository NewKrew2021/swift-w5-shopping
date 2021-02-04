//
//  Product.swift
//  StoreApp
//
//  Created by 이청원 on 2021/02/01.
//

import Foundation

struct Product : Codable {
    let productId : Int
    let productName : String
    let productImage : String
    let originalPrice : Int
    let groupDiscountedPrice : Int?
    let groupDiscountUserCount : Int?
    let storeDomain : String
}
