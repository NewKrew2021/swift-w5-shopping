//
//  ProductHeader.swift
//  StoreApp
//
//  Created by bean Milky on 2021/02/02.
//

import UIKit

class ProductHeader: UICollectionReusableView {
    
    @IBOutlet var title: UILabel!
    static let identifier = "ProductReusableView"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(title: String) {
        self.title.text = title
    }
}
