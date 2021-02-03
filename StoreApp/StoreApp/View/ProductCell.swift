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
        image.load(url: product.productImage)
        title.text = product.title
        price.text = "가격"
        discountedPrice.text = product.discountedPrice
        originalPrice.text = String(product.originalPrice)
        participant.text = product.participant
    }

    override func touchesBegan(_: Set<UITouch>, with _: UIEvent?) {
        Toast(text: "상품명:\(title.text)").start()
    }
}
