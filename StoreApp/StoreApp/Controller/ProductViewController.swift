//
//  ProductViewController.swift
//  StoreApp
//
//  Created by 이청원 on 2021/02/04.
//

import UIKit
import WebKit

class ProductViewController: UIViewController {
    var product : Product?
    private let network = Network()
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var pagingScrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self,
                    selector: #selector(completedJsonParsing),
                    name: NSNotification.Name(rawValue: "jsonParsingProductDetail"),
                    object: nil)
        
        network.getProductDetailData(product: product)
    }

    @objc func completedJsonParsing(_ notification:Notification) {
        DispatchQueue.main.async {
            let productDetail = notification.userInfo?["productDetail"] as! ProductDetail
            self.setViewData(productDetail: productDetail)
        }
    }
    
    func setViewData(productDetail:ProductDetail) {
        self.navigationItem.title = productDetail.data.store.name
        setPagingScrollView(imageUrls: productDetail.data.previewImages)
    }
    
    func setPagingScrollView(imageUrls:[String]) {
        for index in 0..<imageUrls.count {
            let imageView = UIImageView()
            imageView.frame = self.pagingScrollView.bounds
            imageView.frame.origin.x = self.pagingScrollView.bounds.width * CGFloat(index)
            imageView.setImageUrl(imageUrls[index])
            imageView.contentMode = .scaleAspectFill
            self.pagingScrollView.addSubview(imageView)
        }
        self.pagingScrollView.isPagingEnabled = true
        self.pagingScrollView.contentSize = CGSize(width: self.pagingScrollView.bounds.width*CGFloat(imageUrls.count), height: self.pagingScrollView.bounds.width)
        self.pagingScrollView.alwaysBounceVertical = false
    }
}
