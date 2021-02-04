//
//  ProductDetail.swift
//  StoreApp
//
//  Created by bean Milky on 2021/02/04.
//

import Foundation

struct ProductDetailResult: Codable {
    let result: Bool
    let data: ProductDetail
}

struct ProductDetail: Codable {

    let gift: String
    let benefits: [String]
    let booked: Bool
    let productDescription: String
    let previewImages: [String]
    let optionType: String
    let certTypeFood: Bool
    let price: Price
    let id: Int
    let reviewCreatable: Bool
    let delivery: Delivery
    let images: [String]
    let coupon: Bool
    let store: Store
    let taxDeduction: Bool
    let imageRatio: String
    let adultOnly: Bool
    let name: String
    let category: Category
    let favorite: Bool
    let sharingImageUrl: String
    let status: String

    enum CodingKeys: String, CodingKey {
        case gift, benefits, booked
        case productDescription = "description"
        case previewImages, optionType, certTypeFood, price, id, reviewCreatable, delivery, images, coupon, store, taxDeduction, imageRatio, adultOnly, name, category, favorite
        case sharingImageUrl
        case status
    }

}

struct Price: Codable {
    let standardPrice, discountedPrice: Int
    let discountRate: String
    let minDiscountedPrice, maxDiscountedPrice: Int
}

struct Delivery: Codable {
    let deliveryMethodType: String
    let deliveryFeeType, deliveryFeePaymentType: String
    let deliveryFee: Int
    let bundleGroupAvailable: Bool
    let isolatedAreaNotice: String
}

struct Store: Codable {
    let id: Int
    let name, domain: String
    let farmer: Bool
    let coverImage: String
    let profileImage: String
    let introduce, channelName: String
    let channelUrl: String
    let fresh: Bool
}

struct Category: Codable {
    let id, name: String
}
