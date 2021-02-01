//
//  ItemCollectionViewCell.swift
//  StoreApp
//
//  Created by 지현우 on 2021/02/01.
//

import UIKit

class ItemCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var talkDealPriceLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var participantOfDealLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func updateUI(img: UIImage, title: String, talkDealPrice: Int, price: Int, numberOfParticipant: Int){
        imgView.image = img
        titleLabel.text = title
        talkDealPriceLabel.text = "톡딜가 \(talkDealPrice)원"
        priceLabel.text = "\(price)원"
        participantOfDealLabel.text = "현재 \(numberOfParticipant)명 딜 참여중"
    }

}
