//
//  ProductCell.swift
//  StoreApp
//
//  Created by 윤준수 on 2021/02/01.
//

import UIKit
import Toaster

class ProductCell: UICollectionViewCell {
    @IBOutlet var image: UIImageView!
    @IBOutlet var title: UILabel!
    @IBOutlet var price: UILabel!
    @IBOutlet var participant: UILabel!

    func setCell(product: Product) {
        image.load(url: product.productImage)
        title.text = product.title
        price.text = product.price
        participant.text = product.participant
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        Toast.init(text: "상품명:\(title.text)" ).start()
    }
}
