//
//  Product.swift
//  StoreApp
//
//  Created by herb.salt on 2021/02/01.
//  Copyright © 2021 com.kakaocorp. All rights reserved.
//

import Foundation

class Product: Decodable {
    
    let productId: Int
    let productName: String
    let productImage: String
    let originalPrice: Int
    let discountPrice: Int
    let discountedPrice: Int
    let discountRate: Int
    let alarm: Bool
    let storeId: Int
    let storeName: String
    let storeDomain: String
    let storeProfileImage: String
    let linkPath: String
    let plusFriendSubscriberExclusive: Bool
    let farmer: Bool
    let new: Bool
    let alarmDisplaying: Bool

    init(productId: Int, productName: String, productImage: String,
         originalPrice: Int, discountPrice: Int, discountedPrice: Int, discountRate: Int,
         alarm: Bool, storeId: Int, storeName: String, storeDomain: String, storeProfileImage: String,
         linkPath: String, plusFriendSubscriberExclusive: Bool, farmer: Bool, new: Bool, alarmDisplaying: Bool) {
        self.productId = productId
        self.productName = productName
        self.productImage = productImage
        self.originalPrice = originalPrice
        self.discountPrice = discountPrice
        self.discountedPrice = discountedPrice
        self.discountRate = discountRate
        self.alarm = alarm
        self.storeId = storeId
        self.storeName = storeName
        self.storeDomain = storeDomain
        self.storeProfileImage = storeProfileImage
        self.linkPath = linkPath
        self.plusFriendSubscriberExclusive = plusFriendSubscriberExclusive
        self.farmer = farmer
        self.new = new
        self.alarmDisplaying = alarmDisplaying
    }
        
}
