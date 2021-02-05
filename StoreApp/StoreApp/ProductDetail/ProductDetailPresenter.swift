//
//  ProductDetailPresenter.swift
//  StoreApp
//
//  Created by bean Milky on 2021/02/05.
//

import UIKit

extension Notification.Name {
    static let didDownloadImage = Notification.Name("didDownloadImage")
}

protocol ProductDetailPresenterDelegate: AnyObject {
    func addImagetoHorizontalScrollView(image: UIImage)
}

class ProductDetailPresenter {
    
    weak var delegate: ProductDetailPresenterDelegate?
    let viewModel: ProductDetailViewModel
    
    init(viewModel: ProductDetailViewModel) {
        self.viewModel = viewModel
        NotificationCenter.default.addObserver(self, selector: #selector(self.didHorizontalImageDownload), name: .didDownloadImage,
            object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc
    func didHorizontalImageDownload() {
        print("didHorizontalImageDownload")
        viewModel.previewImages.forEach {
            image in
            self.addImagetoHorizontalScrollView(image: image)
        }
    }
    
    func addImagetoHorizontalScrollView(image: UIImage) {
        if let delegate = delegate {
            delegate.addImagetoHorizontalScrollView(image: image)
        }
    }
}
