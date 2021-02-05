//
//  ProductDetailViewController.swift
//  StoreApp
//
//  Created by bean Milky on 2021/02/04.
//

import UIKit

class ProductDetailViewController: UIViewController {

    @IBOutlet var imageScrollView: UIScrollView!
    @IBOutlet var horizontalScrollContentView: UIView!
    @IBOutlet var scrollViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet var descriptionView: UIView!
    private var productDetailPresenter: ProductDetailPresenter?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func setProduct(product: Product?) {
        if let product = product {
            ProductDetailUseCase.getDetail(with: NetworkManager(), from: product.productDetailAddress) { [weak self]
                productDetailViewModel, _ in
                if let viewModel = productDetailViewModel {
                    self?.productDetailPresenter = ProductDetailPresenter(viewModel: viewModel)
                    self?.productDetailPresenter?.setDelegate(with: self as? ProductDetailPresenterDelegate)
                }
            }
        }
    }

}

extension ProductDetailViewController: ProductDetailPresenterDelegate {

    func productDetailPresenter(_ presenter: ProductDetailPresenter, imagesAddedToHorizontalScrollView images: [UIImage]) {
        let screenWidth = UIScreen.main.bounds.width

        for (index, image) in images.enumerated() {
            self.scrollViewWidthConstraint.constant = screenWidth * CGFloat(index)
            let subView = UIImageView(frame: CGRect(x: screenWidth * CGFloat(index), y: 0, width: screenWidth, height: self.horizontalScrollContentView.frame.height))
            subView.image = image
            self.horizontalScrollContentView.addSubview(subView)
        }
    }

    func productDetailPresenter(_ presenter: ProductDetailPresenter, configureDescriptionViewWith viewModel: ProductDetailViewModel) {
        guard let descriptionView = Bundle(for: ProductDescriptionView.self).loadNibNamed("ProductDescriptionView", owner: nil, options: nil)?.first as? ProductDescriptionView else { return }
        self.descriptionView.addSubview(descriptionView)
        descriptionView.configure(viewModel: viewModel)
    }
}
