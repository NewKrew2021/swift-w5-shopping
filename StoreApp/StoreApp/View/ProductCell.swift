//
//  ProductCell.swift
//  StoreApp
//
//  Created by 윤준수 on 2021/02/01.
//

import Toaster
import UIKit

class ProductCell: UICollectionViewCell {
    @IBOutlet var image: UIImageView!
    @IBOutlet var title: UILabel!
    @IBOutlet var price: UILabel!
    @IBOutlet var participant: UILabel!
    @IBOutlet var originalPrice: UILabel!
    @IBOutlet var discountedPrice: UILabel!
    func setCell(product: Product) {
//        image.load(url: product.productImage)
        title.text = product.title
        price.text = "톡딜가"
        discountedPrice.text = product.discountedPrice
        originalPrice.text = String(product.originalPrice)
        participant.text = product.participant
    }
    
    func setImage(image: UIImage){
        self.image.image = image
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        Toast(text: "상품명:\(title.text ?? "") \n가격:\(originalPrice.text ?? "")").start()
    }
}
