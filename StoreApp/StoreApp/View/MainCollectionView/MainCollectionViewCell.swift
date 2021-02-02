//
//  MainCollectionViewCell.swift
//  StoreApp
//
//  Created by herb.salt on 2021/02/02.
//  Copyright © 2021 com.kakaocorp. All rights reserved.
//

import UIKit

class MainCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var itemDiscountedPriceLabel: UILabel!
    @IBOutlet weak var itemOriginalPriceLabel: UILabel!
    @IBOutlet weak var itemUserCountLabel: UILabel!
    
    func makeCell(_ storeItem: StoreItem) {
        
        self.itemNameLabel.text = storeItem.productName
        self.itemOriginalPriceLabel.text = "\(storeItem.originalPrice!)원"
        if let groupDiscountedPrice = storeItem.groupDiscountedPrice {
            self.itemDiscountedPriceLabel.text = "톡딜가 \(groupDiscountedPrice)원"
        }
        if let groupDiscountUserCount = storeItem.groupDiscountUserCount {
            self.itemUserCountLabel.text = "현재 \(groupDiscountUserCount)명 딜 참여중"
        }
        
    }
    
}
