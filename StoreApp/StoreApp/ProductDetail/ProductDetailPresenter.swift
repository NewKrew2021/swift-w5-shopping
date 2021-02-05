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
    func productDetailPresenter(_ presenter: ProductDetailPresenter, imagesAddedToHorizontalScrollView images: [UIImage])
    func productDetailPresenter(_ presenter: ProductDetailPresenter, configureDescriptionViewWith viewModel: ProductDetailViewModel)
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
        self.addImagetoHorizontalScrollView(images: viewModel.previewImages)
    }

    private func addImagetoHorizontalScrollView(images: [UIImage]) {
        if let delegate = delegate {
            delegate.productDetailPresenter(self, imagesAddedToHorizontalScrollView: images)
        }
    }

    func setDelegate(with: ProductDetailPresenterDelegate?) {
        if let with = with {
            self.delegate = with
            configureDescriptionView()
        }
    }

    private func configureDescriptionView() {
        if let delegate = delegate {
            delegate.productDetailPresenter(self, configureDescriptionViewWith: viewModel)
        }
    }

}
