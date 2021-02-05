//
//  ProductViewController.swift
//  StoreApp
//
//  Created by 이청원 on 2021/02/04.
//

import UIKit
import WebKit
import Cosmos

class ProductViewController: UIViewController {
    var product : Product?
    private let network = Network()
    @IBOutlet weak var mainScrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var pagingScrollView: UIScrollView!
    private var offSet: CGFloat = 0
    @IBOutlet weak var ratingView: CosmosView!
    @IBOutlet weak var reviewCountLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    private var purchaseButton: UIButton = UIButton()
    private var talkDealButton: UIButton = UIButton()
    @IBOutlet weak var priceStackView: UIStackView!
    
    
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
        setTimer(imageCount: productDetail.data.previewImages.count)
        setReviewStackView(totalProductStarRating: productDetail.data.review.totalProductStarRating, reviewCount: productDetail.data.review.reviewCount)
        self.titleLabel.text = productDetail.data.name
        setPriceStackView(status: productDetail.data.status, standardPrice: productDetail.data.price.standardPrice, discountedPrice: productDetail.data.price.discountedPrice)
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
            priceStackView.leadingAnchor.constraint(equalTo: mainScrollView.leadingAnchor, constant: 8).isActive = true
            priceStackView.trailingAnchor.constraint(equalTo: mainScrollView.trailingAnchor, constant: -8).isActive = true
            priceStackView.addArrangedSubview(purchaseButton)
            priceStackView.addArrangedSubview(talkDealButton)
        } else {
            purchaseButton.widthAnchor.constraint(equalToConstant: 150).isActive = true
            priceStackView.addArrangedSubview(purchaseButton)
        }
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
}

extension ProductViewController : UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.offSet = self.pagingScrollView.contentOffset.x
    }
}
