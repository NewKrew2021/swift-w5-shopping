//
//  ProductDetailViewController.swift
//  StoreApp
//
//  Created by bean Milky on 2021/02/04.
//

import UIKit
import WebKit

class ProductDetailViewController: UIViewController {

    @IBOutlet var imageScrollView: UIScrollView!
    @IBOutlet var verticalScrollView: UIScrollView!
    @IBOutlet var horizontalScrollContentView: UIView!
    @IBOutlet var scrollViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet var descriptionView: UIView!
    @IBOutlet var webViewContainer: UIView!
    private var webView: WKWebView!
    private var productDetailPresenter: ProductDetailPresenter?

    override func viewDidLoad() {
        super.viewDidLoad()
        setWebView()
    }

    func setProduct(product: Product?) {
        if let product = product {
            ProductDetailUseCase.getDetail(with: NetworkManager(), from: product.productDetailAddress) { [weak self]
                productDetailViewModel, _ in
                if let viewModel = productDetailViewModel {
                    self?.productDetailPresenter = ProductDetailPresenter(viewModel: viewModel)
                    self?.productDetailPresenter?.setDelegate(with: self)
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
        descriptionView.delegate = self
        self.descriptionView.addSubview(descriptionView)
        descriptionView.configure(viewModel: viewModel)
    }

    func productDetailPresenter(_ presenter: ProductDetailPresenter, loadWebViewWith htmlString: String) {
        self.webView.loadHTMLString(htmlString, baseURL: nil)
    }

}

extension ProductDetailViewController: WKUIDelegate, WKNavigationDelegate {
    private func setWebView() {
        let webConfiguration = WKWebViewConfiguration()
        self.webView = WKWebView(frame: webViewContainer.bounds, configuration: webConfiguration)
        self.webView.uiDelegate = self
        self.webView.navigationDelegate = self
        self.webView.scrollView.isScrollEnabled = false
        self.webViewContainer.addSubview(webView)
    }

    func webView(_: WKWebView, didCommit: WKNavigation!) {
        let css = "body {vertical-align: middle; text-align: center;} img {width: -webkit-fill-available;}"
        let js = """
        var style = document.createElement('style'); style.innerHTML = '\(css)'; document.head.appendChild(style); var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);
        """
        self.webView.evaluateJavaScript(js, completionHandler: nil)
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.webView.frame.size = webView.scrollView.contentSize
        verticalScrollView.contentSize = CGSize(width: verticalScrollView.contentSize.width, height: verticalScrollView.contentSize.height+webView.scrollView.contentSize.height-webViewContainer.frame.size.height)
        webViewContainer.frame.size = self.webView.frame.size
    }
}

extension ProductDetailViewController: ProductDescriptionViewDelegate {
    func talkDealTapped() {
        ProductDetailUseCase.buyProduct(with: NetworkManager()) {
            _, _ in
        }
    }
}
