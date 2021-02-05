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
    @IBOutlet weak var mainScrollView: UIScrollView!
    @IBOutlet weak var imageScrollView: UIScrollView!
    var imageViews: [UIImageView] = []
    @IBOutlet weak var webView: WKWebView!
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
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.navigationDelegate = self
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
        }
    }
}
