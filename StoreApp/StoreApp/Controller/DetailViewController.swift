//
//  DetailViewController.swift
//  StoreApp
//
//  Created by 윤준수 on 2021/02/04.
//

import Toaster
import UIKit
import WebKit

class DetailViewController: UIViewController, WKUIDelegate {
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

    func initView() {
        view.addSubview(mainScrollView)
        mainScrollView.translatesAutoresizingMaskIntoConstraints = false
        mainScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        mainScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        mainScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        mainScrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        mainScrollView.backgroundColor = .gray
//        mainScrollView.addSubview(imageView)
//
//        imageView.backgroundColor = .blue
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        imageView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
//        imageView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.75).isActive = true
//        imageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
//        imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        
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
        webView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        webView.topAnchor.constraint(equalTo: imageScrollView.bottomAnchor, constant: 20).isActive = true
        webView.leadingAnchor.constraint(equalTo: mainScrollView.contentLayoutGuide.leadingAnchor).isActive = true
        webView.widthAnchor.constraint(equalTo: mainScrollView.frameLayoutGuide.widthAnchor).isActive = true
        webView.bottomAnchor.constraint(equalTo: mainScrollView.contentLayoutGuide.bottomAnchor).isActive = true
        webView.scrollView.isScrollEnabled = false
        webView.uiDelegate = self
        guard let descriptionHtml = productDetail?.description else { return }
        Toast(text: descriptionHtml).start()
        webView.loadHTMLString(descriptionHtml, baseURL: nil)

        guard let imageUrls = productDetail?.previewImages else { return }
        
        for index in imageUrls.indices {
            let imageView = UIImageView()
            imageViews.append(imageView)
            imageScrollView.addSubview(imageView)
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
            imageView.heightAnchor.constraint(equalTo: imageScrollView.frameLayoutGuide.heightAnchor).isActive = true
            imageView.topAnchor.constraint(equalTo: imageScrollView.contentLayoutGuide.topAnchor).isActive = true
            imageView.leadingAnchor.constraint(equalTo: index == 0 ? imageScrollView.contentLayoutGuide.leadingAnchor : imageViews[index-1].trailingAnchor).isActive = true
            imageView.setImageByUrl(url: imageUrls[index])
        }
        imageViews[0].leadingAnchor.constraint(equalTo: imageScrollView.contentLayoutGuide.leadingAnchor).isActive = true
//        imageViews[imageUrls.count-1].trailingAnchor.constraint(equalTo: imageScrollView.contentLayoutGuide.trailingAnchor).isActive = true
        imageScrollView.contentSize = CGSize(width: view.bounds.width * CGFloat(imageViews.count), height: view.bounds.width * 0.75)
        imageScrollView.isPagingEnabled = true
        
        mainScrollView.contentSize = CGSize(width: view.bounds.width, height: imageScrollView.bounds.height + webView.bounds.height + 20)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        webView = nil
    }
}
