//
//  DetailItem.swift
//  StoreApp
//
//  Created by 이준형 on 2021/02/04.
//  Copyright © 2021 이준형. All rights reserved.
//

import Foundation

struct DetailItem: Decodable
{
    let data: DataClass
    let result : Bool
    enum CodingKeys: String, CodingKey {
        case result
        case data
    }
}

struct DataClass: Codable {
    let benefits: [String]?
    let dataDescription: String?
    let previewImages: [String]?
    let price: Price?
    let review: Review?
    let id: Int?
    let delivery: Delivery?
    let store: Store?
    let notices: [Notice]?
    let name: String?

    enum CodingKeys: String, CodingKey {
        case benefits
        case dataDescription = "description"
        case previewImages, price, review, id, delivery, store, notices, name
    }
}

struct Delivery: Codable {
    let deliveryFeeType: String?
    let deliveryFee: Int?
}

struct Notice: Codable {
    let title: String?
    let createdAt: String?
}

struct Price: Codable {
    let standardPrice: Int?
    let discountedPrice: Int?
}

struct Review: Codable {
    let reviewCount: Int?
    let totalProductStarRating: Float?
}

struct Store: Codable {
    let name: String?
}
