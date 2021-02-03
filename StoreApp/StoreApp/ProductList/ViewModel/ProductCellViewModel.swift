//
//  File.swift
//  StoreApp
//
//  Created by bean Milky on 2021/02/02.
//

import UIKit
import RxSwift

class ProductCellViewModel {
    var productName: String
    var productImage: PublishSubject<UIImage?>
    var groupDiscountedPrice: String? = ""
    var originalPrice: String = ""
    var groupDiscountUserCount: String = ""
    
    init(product: ProductElement) {
        self.productImage = PublishSubject<UIImage?>()
        productName = product.productName
        groupDiscountedPrice = self.changeGroupDiscountedPriceFormat(from: product.groupDiscountedPrice)
        originalPrice = self.changeOriginalPriceFormat(from: product.originalPrice)
        groupDiscountUserCount = self.changeGroupDiscountUserCount(from: product.groupDiscountUserCount)
        self.setProductImage(from: product.productImage)
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
    private func setProductImage(from: String) {
        do {
            try NetworkManager().getResource(from: from) {data, _ in
                if let data = data {
                    self.productImage.onNext(UIImage(data: data))
                }
            }
        } catch {
            self.productImage.onNext(UIImage(named: "default"))
        }
    }
}
