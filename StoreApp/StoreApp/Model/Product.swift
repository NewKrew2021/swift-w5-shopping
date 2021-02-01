//
//  Product.swift
//  StoreApp
//
//  Created by 윤준수 on 2021/02/01.
//

import Foundation
import UIKit

struct Product {
    var imageUrl: String
    var image: UIImage?{
        return UIImage(named: imageUrl)
    }
    var title: String?
    private var _price: Int
    var price: String {
        return "톡딜가"
    }

    private var _participant: Int
    var participant: String {
        return "현재 참여중"
    }
    
    init(imageUrl: String, title: String, price: Int, participant: Int) {
        self.imageUrl = imageUrl
        self.title = title
        self._price = price
        self._participant = participant
    }
}
