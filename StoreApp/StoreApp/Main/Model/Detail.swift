//
//  Detail.swift
//  StoreApp
//
//  Created by 지현우 on 2021/02/04.
//

import Foundation

struct Detail: Codable {
    var data: DetailData
}

struct DetailData: Codable {
    var previewUrls: [String]
    var price: Price
    var review: Review
    var delivery: Delivery
    var description: String
    var status: String
    
    enum CodingKeys: String, CodingKey{
        case previewUrls = "previewImages"
        case price
        case review
        case delivery
        case description
        case status
    }
    
}

struct Price: Codable {
    var standardPrice: Int
    var discountedPrice: Int
}

struct Review: Codable{
    var totalProductStarRating: Float
    var reviewCount: Int
}

struct Delivery: Codable{
    var deliveryFeeType: String
    var deliveryFee: Int
    var isolatedAreaNotice: String?
}
