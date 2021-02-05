//
//  ProductDetailUseCase.swift
//  StoreApp
//
//  Created by bean Milky on 2021/02/05.
//

import UIKit

struct ProductDetailUseCase {

    static func getDetail(with manager: NetworkManable, from: String, completed: @escaping (ProductDetailViewModel?, Error?) -> Void) {
        try? manager.getResource(from: from) {
            (data, _) in
            if let data = data {
                do {
                    let result = try JSONDecoder().decode(ProductDetailResult.self, from: data)
                    ProductDetailUseCase.processProductDetail(with: manager, productDetail: result.data) {viewModel in
                        completed(viewModel, nil)
                    }
                } catch {
                    completed(nil, error)
                }
            }
        }
    }

    static private func processProductDetail(with manager: NetworkManable, productDetail: ProductDetail, completed: @escaping (ProductDetailViewModel) -> Void) {
        let productDetailViewModel = ProductDetailViewModel(productDetail: productDetail)
        let group = DispatchGroup()
        productDetail.previewImages.forEach {
            imageUrl in
            do {
                group.enter()
                try manager.download(from: imageUrl) {
                    imageData, error in
                    guard error == nil else { return }
                    if let data = imageData {
                        productDetailViewModel.addPreviewImage(image: UIImage(data: data))
                    }
                    group.leave()
                }
            } catch {
                productDetailViewModel.addPreviewImage(image: UIImage(named: "default"))
            }
        }
        group.notify(queue: .main, execute: {
            NotificationCenter.default.post(name: NSNotification.Name.didDownloadImage, object: nil)
        })
        completed(productDetailViewModel)
    }

    static func buyProduct(with manager: NetworkManable, completed: @escaping (Data?, Error?) -> Void) {
        let body = ["text": "From Bean Milky, JK 감사합니다!"]
        guard let payload = try? JSONEncoder().encode(body) else { return }

        try? manager.getResource(endPoint: nil, from: EndPoint.paymentUrl, method: RequestMethod.POST, payload: payload) { (data, error) in
            completed(data, error)
        }
    }
}
