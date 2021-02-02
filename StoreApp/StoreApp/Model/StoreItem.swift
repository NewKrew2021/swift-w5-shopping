//
//  StoreItem.swift
//  StoreApp
//
//  Created by herb.salt on 2021/02/02.
//  Copyright © 2021 com.kakaocorp. All rights reserved.
//

import Foundation

class StoreItem: Decodable {
    
    let productId: Int?
    let productName: String?
    let productImage: String?
    let originalPrice: Int?
    let discountPrice: Int?
    let discountedPrice: Int?
    let discountRate: Int?
    let groupDiscountedPrice: Int?
    let groupDiscountWillClosed: Bool?
    let groupDiscountUserCount: Int?
    
}
