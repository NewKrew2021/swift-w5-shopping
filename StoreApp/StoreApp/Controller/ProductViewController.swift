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
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var pagingScrollView: UIScrollView!
    private var offSet: CGFloat = 0
    @IBOutlet weak var ratingView: CosmosView!
    @IBOutlet weak var reviewCountLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
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
