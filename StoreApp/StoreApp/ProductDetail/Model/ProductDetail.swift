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
    let review: Review
    let id: Int
    let reviewCreatable: Bool
    let delivery: Delivery
    let images: [String]
    let quantity: Quantity
    let coupon: Bool
    let store: Store
    let taxDeduction: Bool
    let notices: [Notice]
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
        case previewImages, optionType, certTypeFood, price, review, id, reviewCreatable, delivery, images, quantity, coupon, store, taxDeduction, notices, imageRatio, adultOnly, name, category, favorite, sharingImageUrl, status
    }

}

struct Review: Codable {
    let qnaCount, reviewCount, averageRating: Int
    let totalProductStarRating: Double
    let totalDeliveryStarRating, productPositivePercentage, deliveryPositivePercentage, productStar1Percentage: Int
    let productStar2Percentage, productStar3Percentage, productStar4Percentage: Int
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

struct Quantity: Codable {
    let maxPurchase: Int?
    let maxPurchaseOfBuyer: Int?
    let minPurchase: Int?
    let minPurchaseOfBuyer: Int?
}

struct Notice: Codable {
    let id: Int
    let title, content, createdAt: String
}
