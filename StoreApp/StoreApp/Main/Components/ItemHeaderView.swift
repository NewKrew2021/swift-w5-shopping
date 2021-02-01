//
//  ItemHeaderView.swift
//  StoreApp
//
//  Created by 지현우 on 2021/02/01.
//

import UIKit

class ItemHeaderView: UICollectionReusableView {

    @IBOutlet weak var sectionTitleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .gray
    }
    
}
