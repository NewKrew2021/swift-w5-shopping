//
//  Network.swift
//  StoreApp
//
//  Created by 이청원 on 2021/02/03.
//

import Foundation

struct Network {
    private let request = Request()
    
    func getProductData() {
        for productType in ProductType.allCases {
            request.requestProduct(productType: productType)
        }
    }
    
    func getProductDetailData(product: Product?) {
        request.requestProductDetail(storeDomain: product?.storeDomain ?? "", productId: product?.productId ?? 0)
    }
    
    func postPurchaseItem(purchaseText: String) {
        request.requestPostPurchase(text: purchaseText)
    }
}
