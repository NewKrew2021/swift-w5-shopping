//
//  myDetailView.swift
//  StoreApp
//
//  Created by 이준형 on 2021/02/04.
//  Copyright © 2021 이준형. All rights reserved.
//

import UIKit
import WebKit

class myDetailView: UIScrollView {
    var productImage: UIImageView = UIImageView(image: UIImage(systemName: "cart"))
    var productName: UILabel = UILabel()
    var standardPrice: UIButton = UIButton()
    var discountPrice: UIButton = UIButton()
    var storeName: UILabel = UILabel()
    var deliveryPrice: UILabel = UILabel()
    var noticeTitle: UILabel = UILabel()
    var noticeCreateAt: UILabel = UILabel()
    var productDescription: WKWebView = WKWebView()
    
    private var contentView = UIView()
    
    private var standardPriceLeadingAnchorConstraint : NSLayoutConstraint! = nil
    private var standardPriceCenterXAnchoerConstraint : NSLayoutConstraint! = nil
    private var webViewTopAnchorConstraintWithNoticeCreatedAt : NSLayoutConstraint! = nil
    private var webViewTopAnchorConstraintWithDeliveryFee : NSLayoutConstraint! = nil
    private var webViewHeightAnchorConstraint : NSLayoutConstraint!
    
    var detailItem = DetailStoreItem()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initUI()
        NotificationCenter.default.addObserver(self, selector: #selector(setView), name: NSNotification.Name("saveDetailItem"), object: nil)
    }
    
    func downloadJson(productId: String, storeDomain: String){
        detailItem.downloadJson(productId: productId, storeDomain: storeDomain)
    }
    
    @objc func setView(){
        DispatchQueue.main.async {
            self.productImage.image = self.detailItem.getProductImage()
        }
        productName.text = detailItem.getProductName()
        discountPrice.setTitle(detailItem.getGroupDiscountedPrice(), for: .normal)
        standardPrice.setTitle(detailItem.getOriginalPrice(), for: .normal)
        storeName.text = detailItem.getStoreName()
        deliveryPrice.text = detailItem.getDeliveryPrice()
        noticeTitle.text = detailItem.getNoticeTitle()
        noticeCreateAt.text = detailItem.getNoticeCreateAt()
        productDescription.loadHTMLString(detailItem.getProductDescription(), baseURL: nil)
    }
    
    private func initUI(){
        self.autoresizingMask = [.flexibleRightMargin, .flexibleLeftMargin, .flexibleWidth, .flexibleHeight]
        initContentViewLayout()
        initProductImageView()
        initProduntNameLabel()
        initGroupDiscountedPriceLabel()
        initOriginalPriceLabel()
        initStoreNameLabel()
        initDeliveryPriceLabel()
        initNoticeTitleLabel()
        initNoticeCreateAtLabel()
        initWebViewLabel()
    }
    
    private func initContentViewLayout() {
        self.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.topAnchor.constraint(equalTo: contentLayoutGuide.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: contentLayoutGuide.bottomAnchor).isActive = true
        contentView.leadingAnchor.constraint(equalTo: contentLayoutGuide.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: contentLayoutGuide.trailingAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: frameLayoutGuide.widthAnchor).isActive = true
    }
    
    func initProductImageView(){
        contentView.addSubview(productImage)
        productImage.translatesAutoresizingMaskIntoConstraints = false
        productImage.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        productImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        productImage.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        productImage.heightAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
    }
    
    func initProduntNameLabel(){
        contentView.addSubview(productName)
        productName.translatesAutoresizingMaskIntoConstraints = false
        productName.topAnchor.constraint(equalTo: productImage.bottomAnchor, constant: 10).isActive = true
        productName.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        productName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        productName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        
        productName.lineBreakMode = .byTruncatingTail
        productName.numberOfLines = 2
        productName.font = UIFont.systemFont(ofSize: 20)
        productName.textAlignment = .center
    }
    
    func initGroupDiscountedPriceLabel(){
        contentView.addSubview(discountPrice)
        discountPrice.translatesAutoresizingMaskIntoConstraints = false
        discountPrice.topAnchor.constraint(equalTo: productName.bottomAnchor, constant: 10).isActive = true
        discountPrice.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        discountPrice.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 2/5).isActive = true
        discountPrice.heightAnchor.constraint(equalTo: discountPrice.widthAnchor, multiplier: 1/3).isActive = true
        discountPrice.titleLabel!.textAlignment = .center
        discountPrice.titleLabel!.font = UIFont.boldSystemFont(ofSize: 15)
        discountPrice.setTitleColor(.black, for: .normal)
        discountPrice.layer.cornerRadius = 20
        discountPrice.layer.backgroundColor = UIColor.yellow.cgColor
        
        discountPrice.addTarget(self, action: #selector(onTapButton(button:)), for: .touchUpInside)

    }
    
    @objc func onTapButton(button : UIButton) {
        let str = "\(productName.text!)을(를) \n\(button.titleLabel!.text!)에 구매하셨습니다."

        let userInfo: [AnyHashable: Any] = ["text":str]
        NotificationCenter.default.post(name: NSNotification.Name("showToastDetail"), object: self, userInfo: userInfo)
    }

        
        
    func initOriginalPriceLabel(){
        contentView.addSubview(standardPrice)
        standardPrice.translatesAutoresizingMaskIntoConstraints = false
        standardPrice.topAnchor.constraint(equalTo: productName.bottomAnchor, constant: 10).isActive = true
        standardPriceLeadingAnchorConstraint = standardPrice.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20)
        standardPriceCenterXAnchoerConstraint = standardPrice.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        standardPriceLeadingAnchorConstraint.isActive = true
        standardPriceCenterXAnchoerConstraint.isActive = false
        standardPrice.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 2/5).isActive = true
        standardPrice.heightAnchor.constraint(equalTo: standardPrice.widthAnchor, multiplier: 1/3).isActive = true
        standardPrice.setTitleColor(.white, for: .normal)
        standardPrice.titleLabel!.textAlignment = .center
        standardPrice.titleLabel!.font = UIFont.boldSystemFont(ofSize: 15)
        standardPrice.layer.cornerRadius = 20
        standardPrice.layer.backgroundColor = UIColor.black.cgColor
        standardPrice.addTarget(self, action: #selector(onTapButton(button:)), for: .touchUpInside)
    }
    
    func initStoreNameLabel(){
        contentView.addSubview(storeName)
        storeName.translatesAutoresizingMaskIntoConstraints = false
        storeName.topAnchor.constraint(equalTo: standardPrice.bottomAnchor, constant: 10).isActive = true
        storeName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        storeName.sizeToFit()
        storeName.font = UIFont.boldSystemFont(ofSize: 16)
    }
    
    func initDeliveryPriceLabel(){
        contentView.addSubview(deliveryPrice)
        deliveryPrice.translatesAutoresizingMaskIntoConstraints = false
        deliveryPrice.topAnchor.constraint(equalTo: storeName.bottomAnchor, constant: 10).isActive = true
        deliveryPrice.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        deliveryPrice.sizeToFit()
        deliveryPrice.font = UIFont.systemFont(ofSize: 14)
    }
    
    func initNoticeTitleLabel(){
        contentView.addSubview(noticeTitle)
        noticeTitle.translatesAutoresizingMaskIntoConstraints = false
        noticeTitle.topAnchor.constraint(equalTo: deliveryPrice.bottomAnchor, constant: 15).isActive = true
        noticeTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        noticeTitle.sizeToFit()
    }
    
    func initNoticeCreateAtLabel(){
        contentView.addSubview(noticeCreateAt)
        noticeCreateAt.translatesAutoresizingMaskIntoConstraints = false
        noticeCreateAt.topAnchor.constraint(equalTo: noticeTitle.bottomAnchor, constant: 5).isActive = true
        noticeCreateAt.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        noticeCreateAt.font = UIFont.systemFont(ofSize: 13)
        noticeCreateAt.textColor = .systemGray
    }
    
    func initWebViewLabel(){
        productDescription.navigationDelegate = self
        contentView.addSubview(productDescription)
        productDescription.translatesAutoresizingMaskIntoConstraints = false
        webViewTopAnchorConstraintWithNoticeCreatedAt = productDescription.topAnchor.constraint(equalTo: noticeCreateAt.bottomAnchor, constant: 10)
        webViewTopAnchorConstraintWithDeliveryFee = productDescription.topAnchor.constraint(equalTo: deliveryPrice.bottomAnchor, constant: 10)
        webViewTopAnchorConstraintWithNoticeCreatedAt.isActive = true
        webViewTopAnchorConstraintWithDeliveryFee.isActive = false
        productDescription.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        productDescription.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        productDescription.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    
    
}

extension myDetailView : WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            if self.webViewHeightAnchorConstraint != nil {
                self.webViewHeightAnchorConstraint.isActive = false
            }
            self.webViewHeightAnchorConstraint = self.productDescription.heightAnchor.constraint(equalTo: self.standardPrice.heightAnchor, constant: self.productDescription.scrollView.contentSize.height)
            self.webViewHeightAnchorConstraint.isActive = true
        }
    }
}
