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
    @IBOutlet weak var mainCellView: UIView!
    
    override func awakeFromNib() {
        self.mainCellView.translatesAutoresizingMaskIntoConstraints = false
        self.mainCellView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.width).isActive = true
    }
    
    func setViewData(productName: String, productImage: String, groupDiscountedPrice: Int, originalPrice: Int, groupDiscountUserCount: Int) {
        let imageUrl = URL(string: productImage)
        do {
            let data = try Data(contentsOf: imageUrl!)
            self.imageView.image = UIImage(data: data)
        } catch {
            return
        }
        self.titleLabel.text = productName
        if groupDiscountedPrice == -1 {
            self.discountPriceLabel.text = "\(originalPrice)원"
            self.originalPriceLabel.text = ""
        } else {
            self.discountPriceLabel.text = "톡딜가 \(groupDiscountedPrice)원"
            self.originalPriceLabel.text = "\(originalPrice)원"
        }
        if groupDiscountUserCount != -1 {
            self.participationLabel.text = "현재 \(groupDiscountUserCount)명 딜 참여중"
        } else {
            self.participationLabel.text = ""
        }
    }
}

