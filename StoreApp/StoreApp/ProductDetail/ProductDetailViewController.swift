//
//  ProductDetailViewController.swift
//  StoreApp
//
//  Created by bean Milky on 2021/02/04.
//

import UIKit

class ProductDetailViewController: UIViewController {

    @IBOutlet var imageScrollView: UIScrollView!
    @IBOutlet var scrollContentView: UIView!
    @IBOutlet var scrollViewWidthConstraint: NSLayoutConstraint!
    private var viewModel: ProductDetailViewModel?

    override func viewDidLoad() {
        let screenWidth = UIScreen.main.bounds.width
        super.viewDidLoad()
    }

    func setViewModel(viewModel: ProductDetailViewModel) {
        self.viewModel = viewModel
    }

    func addImagetoScrollView(image: UIImage) {
        let screenWidth = UIScreen.main.bounds.width
        if scrollViewWidthConstraint.constant != 0 {
            scrollViewWidthConstraint.constant += screenWidth
        }
        let view = UIImageView(frame: CGRect(x: screenWidth, y: 0, width: screenWidth, height: scrollContentView.frame.height))
        view.image = image
        scrollContentView.addSubview(view)
    }

}
