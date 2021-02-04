//
//  ShoppingCollectionReusableView.swift
//  StoreApp
//
//  Created by 이청원 on 2021/02/02.
//

import UIKit
import Toaster

class ShoppingCollectionReusableView: UICollectionReusableView {

    @IBOutlet weak var sectionLabel: UILabel!
    
    func setViewData(productType: ProductType) {
        sectionLabel.text = productType.info.korDescription
    }
}
