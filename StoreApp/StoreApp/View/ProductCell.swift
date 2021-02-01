//
//  ProductCell.swift
//  StoreApp
//
//  Created by 윤준수 on 2021/02/01.
//

import UIKit

class ProductCell: UICollectionViewCell {
    @IBOutlet var image: UIImageView!
    @IBOutlet var title: UILabel!
    @IBOutlet var price: UILabel!
    @IBOutlet var participant: UILabel!

    func setCell(product: Product) {
        image.image = product.image
        title.text = product.title
        price.text = product.price
        participant.text = product.participant
    }
}
