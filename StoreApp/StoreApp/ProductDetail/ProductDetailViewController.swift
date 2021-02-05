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
    private var productDetailPresenter: ProductDetailPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func setProduct(product: Product?) {
        if let product = product {
            ProductDetailUseCase.getDetail(with: NetworkManager(), from: product.productDetailAddress) { [weak self]
                productDetailViewModel, error in
                if let viewModel = productDetailViewModel {
                    self?.productDetailPresenter = ProductDetailPresenter(viewModel: viewModel)
                    self?.productDetailPresenter?.delegate = self
                }
            }
        }
    }

}

extension ProductDetailViewController: ProductDetailPresenterDelegate {
    
    func addImagetoHorizontalScrollView(image: UIImage) {
        let screenWidth = UIScreen.main.bounds.width
        if self.scrollViewWidthConstraint.constant != 0 {
            self.scrollViewWidthConstraint.constant += screenWidth
        }
        let subView = UIImageView(frame: CGRect(x: screenWidth, y: 0, width: screenWidth, height: self.horizontalScrollContentView.frame.height))
        subView.image = image
        self.horizontalScrollContentView.addSubview(subView)
        self.view.setNeedsLayout()
        print(subView.image)
    }
    
}
