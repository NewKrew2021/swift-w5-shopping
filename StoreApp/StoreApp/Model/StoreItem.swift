//
//  StoreItem.swift
//  StoreApp
//
//  Created by 이준형 on 2021/02/01.
//  Copyright © 2021 이준형. All rights reserved.
//

import Foundation
import UIKit

struct StoreItem: Decodable {
    let productName: String
    let productImage: String
    let groupDiscountedPrice: Int
    let originalPrice: Int
    let groupDiscountUserCount: Int
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        productName = try values.decode(String.self, forKey: .productName)
        productImage = try values.decode(String.self, forKey: .productImage)
        groupDiscountedPrice = try values.decode(Int.self, forKey: .groupDiscountedPrice)
        originalPrice = try values.decode(Int.self, forKey: .originalPrice)
        groupDiscountUserCount = try values.decode(Int.self, forKey: .groupDiscountUserCount)
    }
    
    enum CodingKeys: String, CodingKey {
           case productName, productImage, groupDiscountedPrice, originalPrice, groupDiscountUserCount
       }
}
