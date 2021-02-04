//
//  Item.swift
//  StoreApp
//
//  Created by 지현우 on 2021/02/01.
//

import Foundation

// MARK: - Item

struct Item: Codable {
    enum CodingKeys: String, CodingKey {
        case id = "productId"
        case name = "productName"
        case imageUrl = "productImage"
        case originalPrice
        case price = "groupDiscountedPrice"
        case numberOfParticipant = "groupDiscountUserCount"
        case storeId
        case storeName
        case storeDomain
    }

    var id: Int
    var name: String
    var imageUrl: String
    var price: Int?
    var originalPrice: Int
    var numberOfParticipant: Int?
    var storeId: Int
    var storeName: String
    var storeDomain: String

    func hasTalkDeal() -> Bool {
        self.price != nil ? true : false
    }
}
