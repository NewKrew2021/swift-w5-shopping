//
//  DetailViewController.swift
//  StoreApp
//
//  Created by herb.salt on 2021/02/05.
//  Copyright © 2021 com.kakaocorp. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UIViewController, WKNavigationDelegate {
    
    @IBOutlet weak var parentView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var standardPriceLabel: UILabel!
    @IBOutlet weak var discountedPriceLabel: UILabel!
    @IBOutlet weak var storeNameLabel: UILabel!
    @IBOutlet weak var deliveryFeeLabel: UILabel!
    @IBOutlet weak var webView: WKWebView!
    var networkManager = NetworkManager()
    var storeItem: StoreItem?
    var webViewHeight: CGFloat = 40
    
    override func viewDidLoad() {
        super.viewDidLoad()
        networkManager.getDetailData(storeItem: storeItem!)
        NotificationCenter.default.addObserver(self, selector: #selector(parseDetailData), name: Notification.Name("getDetailData"), object: nil)
    }
    
    @objc func parseDetailData(_ notification: Notification) {
        
        let jsonData = notification.object as! Data        
        let decoder = JSONDecoder()
        guard let result = try? decoder.decode(StoreItemDetail.self, from: jsonData) else { return }
        self.initView(storeItemDetail: result)
        
    }

    func initView(storeItemDetail: StoreItemDetail) {
     
        self.nameLabel.text = storeItemDetail.data?.name!
        self.standardPriceLabel.text = "바로 구매 \((storeItemDetail.data?.price?.standardPrice)!)원"
        if storeItemDetail.data?.status! == "ON_SALE" {
            self.discountedPriceLabel.text = "톡딜가 \((storeItemDetail.data?.price?.discountedPrice)!)원"
        }
        self.storeNameLabel.text = storeItemDetail.data?.store?.name!
        if storeItemDetail.data?.delivery?.deliveryFeeType == "FREE" {
            self.deliveryFeeLabel.text = "배송비 무료"
        }
        else {
            self.deliveryFeeLabel.text = "배송비 \((storeItemDetail.data?.delivery?.deliveryFee)!)원"
        }
        
    }

}
