//
//  ShoppingCollectionReusableView.swift
//  StoreApp
//
//  Created by 이청원 on 2021/02/02.
//

import UIKit

class ShoppingCollectionReusableView: UICollectionReusableView {

    @IBOutlet weak var sectionLabel: UILabel!
    
    func setViewData(productType: ProductType) {
        switch productType {
        case .best: sectionLabel.text = "베스트"
        case .mask: sectionLabel.text = "마스크"
        case .grocery: sectionLabel.text = "잡화"
        case .fryingpan: sectionLabel.text = "프라이팬"
        }
    }
}
