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
    
    func setViewData(productName: String, productImage: String, groupDiscountedPrice: Int, originalPrice: Int, groupDiscountUserCount: Int) {
        let imageUrl = URL(string: productImage)
        do {
            let data = try Data(contentsOf: imageUrl!)
            self.imageView.image = UIImage(data: data)
        } catch {
            return
        }
        self.titleLabel.text = productName
        self.priceLabel.text = "\(originalPrice)"
    }
}

