//
//  ProductViewController.swift
//  StoreApp
//
//  Created by 이청원 on 2021/02/04.
//

import UIKit

class ProductViewController: UIViewController {
    var product : Product?
    private let network = Network()
    @IBOutlet weak var mainScrollView: DetailScrollView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self,
                    selector: #selector(completedJsonParsing),
                    name: NSNotification.Name(rawValue: "jsonParsingProductDetail"),
                    object: nil)
        
        mainScrollView.uiButtonDeleage = self
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
        mainScrollView.setViewData(productDetail: productDetail)
    }
}

extension ProductViewController : UIButtonDelegate {
    func purchaseItem(purchaseText: String) {
        network.postPurchaseItem(purchaseText: purchaseText)
    }
}
