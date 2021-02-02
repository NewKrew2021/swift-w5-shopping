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
    let discountPrice : Int
    let discountedPrice : Int
    let discountRate : Int
    let groupDiscountedPrice : Int?
    let groupDiscountWillClosed : Bool?
    let groupDiscountUserCount : Int?
    let alarm : Bool
    let groupDiscountRemainSeconds : Int?
    let storeId : Int
    let storeName : String
    let storeDomain : String
    let storeProfileImage : String
    let linkPath : String
    let storeLinkPath : String
    let plusFriendSubscriberExclusive : Bool
    let farmer : Bool
    let reviewCount : Int
    let reviewProductRating : Int
    let productPositivePercentage : Int
    let rank : Int
    let new : Bool
    let alarmDisplaying : Bool
}
