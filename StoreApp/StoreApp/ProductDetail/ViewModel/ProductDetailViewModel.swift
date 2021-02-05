//
//  ProductDetailViewModel.swift
//  StoreApp
//
//  Created by bean Milky on 2021/02/04.
//

import UIKit

class ProductDetailViewModel {

    let productDescription: String
    var previewImages: [UIImage] = []
    let optionType: String
    let price: Price
    let review: Review
    let id: Int
    let reviewCreatable: Bool
    let delivery: Delivery
    var images: [UIImage] = []
    let quantity: Quantity
    let coupon: Bool
    let store: Store
    let taxDeduction: Bool
    let imageRatio: String
    let name: String
    let category: Category
    let favorite: Bool
    let sharingImageUrl: String
    var starRating: String {
        return String(Array(0..<Int(review.totalProductStarRating)).map { _ in "⭐️" })
    }

    init(productDetail: ProductDetail) {
        productDescription = productDetail.productDescription
        optionType = productDetail.optionType
        price = productDetail.price
        review = productDetail.review
        id = productDetail.id
        reviewCreatable = productDetail.reviewCreatable
        delivery = productDetail.delivery
        quantity = productDetail.quantity
        coupon = productDetail.coupon
        store = productDetail.store
        taxDeduction = productDetail.taxDeduction
        imageRatio = productDetail.imageRatio
        name = productDetail.name
        category = productDetail.category
        favorite = productDetail.favorite
        sharingImageUrl = productDetail.sharingImageUrl
    }

    func addPreviewImage(image: UIImage?) {
        guard let image = image else { return }
        self.previewImages.append(image)
    }

    func addImage(image: UIImage?) {
        guard let image = image else { return }
        self.images.append(image)
    }
}
