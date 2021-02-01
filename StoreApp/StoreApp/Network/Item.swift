//
//  Item.swift
//  StoreApp
//
//  Created by 지현우 on 2021/02/01.
//

import Foundation

// MARK: - Items

struct Items: Codable {
    var items: [Item]
}

// MARK: - Item

struct Item: Codable {
    enum CodingKeys: String, CodingKey {
        case id = "productId"
        case name = "productName"
        case imageUrl = "productImage"
        case originalPrice = "originalPrice"
        case price = "groupDiscountedPrice"
        case numberOfParticipant = "groupDiscountUserCount"
        case storeId = "storeId"
        case storeName = "storeName"
    }
    var id: Int
    var name: String
    var imageUrl: String
    var price: Int?
    var originalPrice: Int
    var numberOfParticipant: Int?
    var storeId: Int
    var storeName: String
}

// MARK: - Product

struct Product: Codable {}

// MARK: - Group

struct Group: Codable {}

// MARK: - Store

struct Store: Codable {}
