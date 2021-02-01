//
//  Product.swift
//  StoreApp
//
//  Created by bean Milky on 2021/02/01.
//

import Foundation

// MARK: - ProductElement
struct ProductElement: Codable, Hashable {
    enum ProductType: String, Codable {
        case BEST, MASK, GROCERY, FRYINGPAN

        init?(rawValue: String) {
            switch rawValue {
            case "BEST":
                self = .BEST
            case "MASK":
                self = .MASK
            case "GROCERY":
                self = .GROCERY
            case "FRYINGPAN":
                self = .FRYINGPAN
            default: return nil
            }
        }
    }
    let productId: Int
    let productName: String
    let productImage: String
    let originalPrice, discountPrice, discountedPrice, discountRate: Int
    let groupDiscountedPrice: Int?
    let groupDiscountWillClosed: Bool?
    let groupDiscountUserCount: Int?
    let alarm: Bool
    let groupDiscountRemainSeconds: Int?
    let storeId: Int
    let storeName, storeDomain: String
    let storeProfileImage: String
    let linkPath: String
    let storeLinkPath: String?
    let plusFriendSubscriberExclusive, farmer: Bool
    let reviewCount, reviewProductRating, productPositivePercentage, rank: Int?
    let new, alarmDisplaying: Bool
    let impId: String?
    var type: ProductType?
    let identifier = UUID()

    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
    static func == (lhs: ProductElement, rhs: ProductElement) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    func contains(_ filter: String?) -> Bool {
        guard let filterText = filter else { return true }
        if filterText.isEmpty { return true }
        return productName.contains(filterText)
    }
}
