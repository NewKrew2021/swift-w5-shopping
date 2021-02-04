//
//  Product.swift
//  StoreApp
//
//  Created by bean Milky on 2021/02/01.
//

import UIKit
import RxSwift

class Product: Hashable, NSCopying {
    enum ProductType: String {
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
    let groupDiscountedPrice: Int
    let originalPrice: Int
    let groupDiscountUserCount: Int
    let type: ProductType
    let storeName, storeDomain: String
    var productDetailAddress: String {
        return "https://store.kakao.com/a/\(storeDomain)/product/\(productId)/detail"
    }
    let identifier = UUID()
    private(set) var productImage: ReplaySubject<UIImage?> = ReplaySubject<UIImage?>.create(bufferSize: 1)

    init(productElement: ProductElement, type productType: ProductType) {
        productId = productElement.productId
        productName = productElement.productName
        groupDiscountedPrice = productElement.groupDiscountedPrice ?? productElement.originalPrice
        originalPrice = productElement.originalPrice
        groupDiscountUserCount = productElement.groupDiscountUserCount ?? 0
        storeName = productElement.storeName
        storeDomain = productElement.storeDomain
        type = productType
    }

    init(productId: Int, productName: String, groupDiscountedPrice: Int, originalPrice: Int, groupDiscountUserCount: Int, storeName: String, storeDomain: String, type productType: ProductType) {
        self.productId = productId
        self.productName = productName
        self.groupDiscountedPrice = groupDiscountedPrice
        self.originalPrice = originalPrice
        self.groupDiscountUserCount = groupDiscountUserCount
        self.storeName = storeName
        self.storeDomain = storeDomain
        self.type = productType
    }

    func setImage(image: UIImage?) {
        productImage.onNext(image)
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
    static func == (lhs: Product, rhs: Product) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    func contains(_ filter: String?) -> Bool {
        guard let filterText = filter else { return true }
        if filterText.isEmpty { return true }
        return productName.contains(filterText)
    }
    func copy(with zone: NSZone? = nil) -> Any {
        let copy = Product(productId: productId, productName: productName, groupDiscountedPrice: groupDiscountedPrice, originalPrice: originalPrice, groupDiscountUserCount: groupDiscountUserCount, storeName: storeName, storeDomain: storeDomain, type: type)
        return copy
    }
}

// MARK: - ProductElement from Network
struct ProductElement: Codable {

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
}
