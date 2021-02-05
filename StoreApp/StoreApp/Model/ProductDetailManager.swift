//
//  ProductDetailManager.swift
//  StoreApp
//
//  Created by 윤준수 on 2021/02/05.
//

import Foundation

class ProductDetailManager {
    static let instance = ProductDetailManager()
    var productDetail: ProductDetail?
    var previewImages: [URL]? {
        return productDetail?.previewImages
    }

    private init() {}

    public func getProductDetail(storeDomain: String, productId: Int, productTitle: String) {
        NetworkHandler.getData(storeDomain: storeDomain, productId: productId) { data in
            let decoder = JsonDecoder()
            self.productDetail = decoder.parseDataToDetail(data: data)
            self.productDetail?.title = productTitle
            NotificationCenter.default.post(name: .getProductDetailFinished, object: nil)
        }
    }
}

extension Notification.Name {
    static let getProductDetailFinished = Notification.Name("getProductDetailFinished")
}
