//
//  myDetailViewController.swift
//  StoreApp
//
//  Created by 이준형 on 2021/02/03.
//  Copyright © 2021 이준형. All rights reserved.
//

import Foundation
import UIKit
import Toaster
import WebKit

class myDetailViewController:  UIViewController {
    
    var productId : String = ""
    var storeDomain = ""
    var detailItem = DetailStoreItem()
    var detailView : myDetailView?
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var standardPrice: UILabel!
    @IBOutlet weak var discountPrice: UILabel!
    @IBOutlet weak var storeName: UILabel!
    @IBOutlet weak var deliveryPrice: UILabel!
    @IBOutlet weak var noticeTitle: UILabel!
    @IBOutlet weak var noticeCreateAt: UILabel!
    @IBOutlet weak var productDescription: WKWebView!
    
    @IBOutlet weak var myScrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.title = "손안에 쇼핑"
        NotificationCenter.default.addObserver(self, selector: #selector(setView(notification:)), name: NSNotification.Name("saveDetailItem"), object: nil)
    }
    
    var webViewHeight: CGFloat = 40
    @objc func setView(notification: Notification){
        initProductImage()
        initProduntName()
        initGroupDiscountedPrice()
        initOriginalPrice()
        initStoreName()
        initDeliveryPrice()
        initNoticeTitle()
        initNoticeCreateAt()
        initWebView()
    }
    func initVC(productId : String, storeDomain : String){
        detailItem.downloadJson(productId: productId, storeDomain: storeDomain)
    }
    
    func initProductImage() {
        productImage.image = detailItem.getProductImage()
        
    }
    func initProduntName(){
        productName.text = detailItem.getProductName()
    }
    func initGroupDiscountedPrice(){
        
        discountPrice.layer.cornerRadius = 20
        discountPrice.text = detailItem.getGroupDiscountedPrice()
    }
    func initOriginalPrice(){
        standardPrice.layer.cornerRadius = 20
        standardPrice.text = detailItem.getOriginalPrice()
    }
    func initStoreName(){
        storeName.text = detailItem.getStoreName()
    }
    func initDeliveryPrice(){
        deliveryPrice.text = detailItem.getDeliveryPrice()
    }
    func initNoticeTitle(){
        noticeTitle.text = detailItem.getNoticeTitle()
    }
    func initNoticeCreateAt(){
        noticeCreateAt.text = detailItem.getNoticeCreateAt()
    }
    func initWebView(){
        productDescription.loadHTMLString(detailItem.getProductDescription(), baseURL: nil)
    }
    
}
