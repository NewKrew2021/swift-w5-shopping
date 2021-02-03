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
    @IBOutlet weak var discountPriceLabel: UILabel!
    @IBOutlet weak var originalPriceLabel: UILabel!
    @IBOutlet weak var participationLabel: UILabel!
    
    override func awakeFromNib() {
        self.contentView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.width).isActive = true
    }
    
    func setViewData(product: Product) {
        let imageUrl = URL(string: product.productImage)
        do {
            let data = try Data(contentsOf: imageUrl!)
            self.imageView.image = UIImage(data: data)
        } catch {
            return
        }
        self.titleLabel.text = product.productName
        if product.groupDiscountedPrice == nil {
            self.discountPriceLabel.text = "\(product.originalPrice)원"
            self.originalPriceLabel.text = ""
        } else {
            self.discountPriceLabel.text = "톡딜가 \(product.groupDiscountedPrice ?? 0)원"
            self.originalPriceLabel.text = "\(product.originalPrice)원"
        }
        if product.groupDiscountUserCount != nil {
            self.participationLabel.text = "현재 \(product.groupDiscountUserCount ?? 0)명 딜 참여중"
        } else {
            self.participationLabel.text = ""
        }
    }
}

