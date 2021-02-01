//
//  ShoppingCollectionViewCell.swift
//  StoreApp
//
//  Created by 이청원 on 2021/02/01.
//

import UIKit

class ShoppingCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var participationLabel: UILabel!
    
    func getCellHeight() -> CGFloat {
        let imageViewHeight = self.imageView.frame.height
        let titleLabelHeight = self.titleLabel.frame.height
        let priceLabelHeight = self.priceLabel.frame.height
        let participationLabelHeight = self.participationLabel.frame.height
        return imageViewHeight + titleLabelHeight + priceLabelHeight + participationLabelHeight + 25
    }
}

