//
//  DetailViewController.swift
//  StoreApp
//
//  Created by 윤준수 on 2021/02/04.
//

import Toaster
import UIKit
import WebKit

class DetailViewController: UIViewController {
    let mainScrollView = UIScrollView()
    let imageScrollView = UIScrollView()
    var imageViews: [UIImageView] = []
    var imageStackView = UIStackView()
    var webView: WKWebView!
    var productDetail: ProductDetail?
    override func viewDidLoad() {
        super.viewDidLoad()

        initView()
    }

    func initData(storeDomain: String, productId: Int) {
        NetworkHandler.getData(storeDomain: storeDomain, productId: productId) { data in
            let decoder = JsonDecoder()
            guard let detail = decoder.parseDataToDetail(data: data) else { return }
            self.productDetail = detail
            DispatchQueue.main.async { [self] in
                setImageAtImageScroll()
                loadDescription()
            }
        }
    }

    func initView() {
        view.addSubview(mainScrollView)
        mainScrollView.translatesAutoresizingMaskIntoConstraints = false
        mainScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        mainScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        mainScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        mainScrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true

        mainScrollView.addSubview(imageScrollView)
        imageScrollView.translatesAutoresizingMaskIntoConstraints = false
        imageScrollView.widthAnchor.constraint(equalTo: mainScrollView.frameLayoutGuide.widthAnchor).isActive = true
        imageScrollView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.75).isActive = true
        imageScrollView.topAnchor.constraint(equalTo: mainScrollView.contentLayoutGuide.topAnchor).isActive = true
        imageScrollView.leadingAnchor.constraint(equalTo: mainScrollView.contentLayoutGuide.leadingAnchor).isActive = true

        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        mainScrollView.addSubview(webView)
        webView.translatesAutoresizingMaskIntoConstraints = false
//        webView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        webView.widthAnchor.constraint(equalTo: mainScrollView.frameLayoutGuide.widthAnchor).isActive = true
        webView.topAnchor.constraint(equalTo: imageScrollView.bottomAnchor, constant: 20).isActive = true
        webView.bottomAnchor.constraint(equalTo: mainScrollView.contentLayoutGuide.bottomAnchor).isActive = true
        webView.leadingAnchor.constraint(equalTo: mainScrollView.contentLayoutGuide.leadingAnchor).isActive = true
        webView.scrollView.isScrollEnabled = false
        webView.navigationDelegate = self

        mainScrollView.contentSize = CGSize(width: view.bounds.width, height: imageScrollView.bounds.height + webView.bounds.height + 20)
    }

    func setImageAtImageScroll() {
        guard let imageUrls = productDetail?.previewImages else { return }
        for index in imageUrls.indices {
            let imageView = UIImageView()
            imageViews.append(imageView)
            imageScrollView.addSubview(imageView)
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
            imageView.heightAnchor.constraint(equalTo: imageScrollView.frameLayoutGuide.heightAnchor).isActive = true
            imageView.topAnchor.constraint(equalTo: imageScrollView.contentLayoutGuide.topAnchor).isActive = true
            imageView.leadingAnchor.constraint(equalTo: index == 0 ? imageScrollView.contentLayoutGuide.leadingAnchor : imageViews[index - 1].trailingAnchor).isActive = true
            imageView.setImageByUrl(url: imageUrls[index])
        }
        imageViews[0].leadingAnchor.constraint(equalTo: imageScrollView.contentLayoutGuide.leadingAnchor).isActive = true
        imageScrollView.contentSize = CGSize(width: view.bounds.width * CGFloat(imageViews.count), height: view.bounds.width * 0.75)
        imageScrollView.isPagingEnabled = true
    }

    func loadDescription() {
        let meta_java : String = "<meta name=\"viewport\" content=\"width=device-width, shrink-to-fit=YES\">"

        guard let descriptionHtml = productDetail?.description else { return }
        webView.loadHTMLString(meta_java + descriptionHtml, baseURL: nil)
        webView.centerXAnchor.constraint(equalTo: mainScrollView.contentLayoutGuide.centerXAnchor).isActive = true
        webView.widthAnchor.constraint(equalTo: mainScrollView.frameLayoutGuide.widthAnchor).isActive = true
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        webView = nil
    }
}

extension DetailViewController: WKNavigationDelegate{
    func webView(_ webView: WKWebView, didFinish _: WKNavigation!) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.webView.heightAnchor.constraint(equalToConstant: webView.scrollView.contentSize.height).isActive = true
            self.mainScrollView.contentSize = CGSize(width: self.view.bounds.width, height: self.imageScrollView.bounds.height + self.webView.bounds.height + 20)
        }
    }
}
