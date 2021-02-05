//
//  ProductDescriptionView.swift
//  StoreApp
//
//  Created by bean Milky on 2021/02/05.
//

import UIKit

class ProductDescriptionView: UIView {

    @IBOutlet var reviews: UILabel!
    @IBOutlet var productName: UILabel!
    @IBOutlet var buyNowButton: UIButton!
    @IBOutlet var talkDealButton: UIButton!
    @IBOutlet var storeName: UILabel!
    @IBOutlet var participants: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func configure(viewModel: ProductDetailViewModel) {
        reviews.text = "\(viewModel.starRating) 리뷰 \(viewModel.review.reviewCount)건"
        productName.text = viewModel.name
        buyNowButton.setTitle("바로 구매 \(viewModel.price.standardPrice)원", for: .normal)
        talkDealButton.setTitle("톡 딜가 \(viewModel.price.discountedPrice)원", for: .normal)
        storeName.text = viewModel.store.channelName
        participants.text = "딜 \(viewModel.quantity.maxPurchaseOfBuyer ?? viewModel.quantity.minPurchase ?? 0) 참여"
    }

}
