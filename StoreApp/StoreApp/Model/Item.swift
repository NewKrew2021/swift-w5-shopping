//
//  StoreItem.swift
//  StoreApp
//
//  Created by 이준형 on 2021/02/01.
//  Copyright © 2021 이준형. All rights reserved.
//

import Foundation
import UIKit

struct Item: Decodable {
    let productName: String
    let productImage: String
    let groupDiscountedPrice: Int?
    let originalPrice: Int?
    let groupDiscountUserCount: Int?
    
    enum CodingKeys: String, CodingKey {
        case productName , productImage, groupDiscountedPrice, originalPrice, groupDiscountUserCount
    }
}
