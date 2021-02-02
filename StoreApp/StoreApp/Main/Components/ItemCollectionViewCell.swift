//
//  ItemCollectionViewCell.swift
//  StoreApp
//
//  Created by 지현우 on 2021/02/01.
//

import UIKit

class ItemCollectionViewCell: UICollectionViewCell {
    @IBOutlet var imgView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var talkDealPriceLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var participantOfDealLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        imgView.sizeToFit()
        backgroundColor = .white
    }
    
    func updateImage(img: UIImage) {
        imgView.image = img
    }

    func updateUI(title: String, talkDealPrice: Int?, price: Int, numberOfParticipant: Int?) {
        titleLabel.text = title
        priceLabel.text = "\(price)원"
        if let talkDealPrice = talkDealPrice {
            talkDealPriceLabel.text = "톡딜가 \(talkDealPrice)원"
        } else {
            talkDealPriceLabel.text = ""
        }
        if let numberOfParticipant = numberOfParticipant {
            participantOfDealLabel.text = "현재 \(numberOfParticipant)명 딜 참여중"
        } else {
            participantOfDealLabel.text = ""
        }
    }
}
