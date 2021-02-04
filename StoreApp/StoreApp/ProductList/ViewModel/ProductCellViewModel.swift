//
//  File.swift
//  StoreApp
//
//  Created by bean Milky on 2021/02/02.
//

import UIKit
import RxSwift

class ProductCellViewModel {
    let disposeBag = DisposeBag()
    private(set) var productName: String
    private(set) var productImage: ReplaySubject<UIImage?>!
    private(set) var groupDiscountedPrice: String?
    private(set) var originalPrice: String = ""
    private(set) var groupDiscountUserCount: String = ""
    
    init(product: Product) {
        productName = product.productName
        groupDiscountedPrice = self.changeGroupDiscountedPriceFormat(from: product.groupDiscountedPrice)
        originalPrice = self.changeOriginalPriceFormat(from: product.originalPrice)
        groupDiscountUserCount = self.changeGroupDiscountUserCount(from: product.groupDiscountUserCount)
        bindProductImage(productImage: product.productImage)
    }

    private func changeGroupDiscountedPriceFormat(from: Int?) -> String {
        return String(from ?? 0)
    }
    private func changeOriginalPriceFormat(from: Int) -> String {
        return String(from)
    }
    private func changeGroupDiscountUserCount(from: Int?) -> String {
        return String(from ?? 0)
    }
    
    private func bindProductImage(productImage: ReplaySubject<UIImage?>) {
        self.productImage = productImage
    }
}
