//
//  DetailScrollView.swift
//  StoreApp
//
//  Created by 이청원 on 2021/02/05.
//

import UIKit
import Cosmos
import WebKit

class DetailScrollView: UIScrollView, UIScrollViewDelegate {
    
    @IBOutlet weak var pagingScrollView: UIScrollView!
    private var offSet: CGFloat = 0
    @IBOutlet weak var ratingView: CosmosView!
    @IBOutlet weak var reviewCountLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    private var purchaseButton: UIButton = UIButton()
    private var talkDealButton: UIButton = UIButton()
    @IBOutlet weak var priceStackView: UIStackView!
    @IBOutlet weak var storeNameLabel: UILabel!
    @IBOutlet weak var deliveryLabel: UILabel!
    @IBOutlet weak var webView: WKWebView!
    var uiButtonDeleage : UIButtonDelegate?
    private var productDetail : ProductDetail?
    
    func setViewData(productDetail:ProductDetail) {
        self.productDetail = productDetail
        setPagingScrollView(imageUrls: productDetail.data.previewImages)
        setTimer(imageCount: productDetail.data.previewImages.count)
        setReviewStackView(totalProductStarRating: productDetail.data.review.totalProductStarRating, reviewCount: productDetail.data.review.reviewCount)
        self.titleLabel.text = productDetail.data.name
        setPriceStackView(status: productDetail.data.status, standardPrice: productDetail.data.price.standardPrice, discountedPrice: productDetail.data.price.discountedPrice)
        self.storeNameLabel.text = productDetail.data.store.name
        setDelivery(deliveryFeeType: productDetail.data.delivery.deliveryFeeType, deliveryFee: productDetail.data.delivery.deliveryFee)
        setWebView(description: productDetail.data.description)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.offSet = self.pagingScrollView.contentOffset.x
    }
    
    func setPagingScrollView(imageUrls:[String]) {
        self.pagingScrollView.delegate = self
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
    
    func setTimer(imageCount: Int) {
        Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(autoScroll), userInfo: ["imageCount" : imageCount], repeats: true)
    }
    
    func setReviewStackView(totalProductStarRating:Double, reviewCount:Int) {
        var cosmosSetting = CosmosSettings()
        cosmosSetting.totalStars = Int(ceil(totalProductStarRating))
        cosmosSetting.starSize = 13
        cosmosSetting.filledColor = .systemBlue
        cosmosSetting.filledBorderColor = .systemBlue
        cosmosSetting.starMargin = 0
        self.ratingView.rating = totalProductStarRating
        ratingView.settings = cosmosSetting
        self.reviewCountLabel.text = "리뷰 \(reviewCount)건"
    }
    
    func setPriceStackView(status:String, standardPrice: Int, discountedPrice: Int?) {
        purchaseButton.setTitle("바로 구매 \(standardPrice)원", for: .normal)
        purchaseButton.setTitleColor(.white, for: .normal)
        purchaseButton.backgroundColor = .black
        purchaseButton.heightAnchor.constraint(equalTo: purchaseButton.widthAnchor, multiplier: 2.0/5.0).isActive = true
        purchaseButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        purchaseButton.layer.cornerRadius = 30
        talkDealButton.setTitle("톡딜가 \(discountedPrice ?? 0)원", for: .normal)
        talkDealButton.setTitleColor(.black, for: .normal)
        talkDealButton.backgroundColor = .yellow
        talkDealButton.heightAnchor.constraint(equalTo: talkDealButton.widthAnchor, multiplier: 2.0/5.0).isActive = true
        talkDealButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        talkDealButton.layer.cornerRadius = 30
        if status == "ON_SALE" {
            priceStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8).isActive = true
            priceStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8).isActive = true
            priceStackView.addArrangedSubview(purchaseButton)
            priceStackView.addArrangedSubview(talkDealButton)
            talkDealButton.addTarget(self, action: #selector(clickedPurchaseButton), for: .touchUpInside)
        } else {
            purchaseButton.widthAnchor.constraint(equalToConstant: 150).isActive = true
            priceStackView.addArrangedSubview(purchaseButton)
        }
        purchaseButton.addTarget(self, action: #selector(clickedTalkDealButton), for: .touchUpInside)
    }
    
    @objc func autoScroll(timer : Timer) {
        guard let userInfo = timer.userInfo as? [String: Int] else {return}
        let totalPossibleOffset = self.pagingScrollView.bounds.size.width * CGFloat((userInfo["imageCount"] ?? 1)-1)
        if offSet == totalPossibleOffset {
            offSet = 0
        } else {
            offSet += self.pagingScrollView.bounds.size.width
        }
        DispatchQueue.main.async() {
            UIView.animate(withDuration: 0.1, delay: 0, options: UIView.AnimationOptions.curveLinear, animations: {
                self.pagingScrollView.contentOffset.x = CGFloat(self.offSet)
            }, completion: nil)
        }
    }
    
    func setDelivery(deliveryFeeType: String, deliveryFee: Int) {
        if deliveryFeeType == "FREE" {
            deliveryLabel.text = "배송비 무료"
        } else {
            deliveryLabel.text = "배송비 \(deliveryFee)원"
        }
    }
    
    func setWebView(description: String) {
        self.webView.navigationDelegate = self
        self.webView.scrollView.isScrollEnabled = false
        self.webView.loadHTMLString(description, baseURL: nil)
        self.webView.sizeToFit()
    }
    
    @objc func clickedPurchaseButton() {
        uiButtonDeleage?.purchaseItem(purchaseText: "Blue \(self.productDetail?.data.name ?? "") \(self.productDetail?.data.price.standardPrice ?? 0)원 주문완료")
    }
    
    @objc func clickedTalkDealButton() {
        uiButtonDeleage?.purchaseItem(purchaseText: "Blue \(self.productDetail?.data.name ?? "") \(self.productDetail?.data.price.discountedPrice ?? 0)원 주문완료")
    }
}

extension DetailScrollView : WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.webView.heightAnchor.constraint(equalToConstant: webView.scrollView.contentSize.height).isActive = true
        }
    }
}
