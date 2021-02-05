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

    enum Status: String, Codable {
        case ON_SALE, SOLD_OUT
    }
    
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
    let name: String
    let category: Category
    let favorite: Bool
    let sharingImageUrl: String
    let status: Status
    
    enum CodingKeys: String, CodingKey {
        case gift, benefits, booked
        case productDescription = "description"
        case previewImages, optionType, certTypeFood, price, id, reviewCreatable, delivery, images, coupon, store, taxDeduction, imageRatio, name, category, favorite
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
    
    enum DeliveryFeeType: String, Codable {
        case FREE, CONDITIONAL_FREE
    }
    
    let deliveryMethodType: String
    let deliveryFeeType: DeliveryFeeType
    let deliveryFeePaymentType: String
    let deliveryFee: Int
    let bundleGroupAvailable: Bool
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
