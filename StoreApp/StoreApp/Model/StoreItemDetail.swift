//
//  StoreItemDetail.swift
//  StoreApp
//
//  Created by herb.salt on 2021/02/05.
//  Copyright © 2021 com.kakaocorp. All rights reserved.
//

import Foundation

class StoreItemDetail: Decodable {
    let result: Bool?
    let data: StoreItemDetailData?
}


class StoreItemDetailData: Decodable {
    let name: String?
    let status: String?
    let previewImages: [String]?
    let description: String?
    let price: StoreItemDetailPrice?
    let store: StoreItemDetailStore?
    let delivery: StoreItemDetailDelivery?
    let review: StoreItemDetailReview?
}

class StoreItemDetailPrice: Decodable {
    let standardPrice: Int?
    let discountedPrice: Int?
}

class StoreItemDetailStore: Decodable {
    let name: String?
}

class StoreItemDetailDelivery: Decodable {
    let deliveryFeeType: String?
    let deliveryFee: Int?
}

class StoreItemDetailReview: Decodable {
    let totalProductStarRating: Float?
    let reviewCount: Int?
}
