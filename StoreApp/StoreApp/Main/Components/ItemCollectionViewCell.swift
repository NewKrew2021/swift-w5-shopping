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

    func update(img: UIImage) {
        imgView.image = img
    }

    func update(title: String, price: Int, talkDealPrice: Int, numberOfParticipant: Int) {
        titleLabel.text = title
        priceLabel.text = "\(price)원"
        talkDealPriceLabel.text = "톡딜가 \(talkDealPrice)원"
        participantOfDealLabel.text = "현재 \(numberOfParticipant)명 딜 참여중"
    }

    func update(title: String, price: Int) {
        titleLabel.text = title
        priceLabel.text = "\(price)원"
    }
}
