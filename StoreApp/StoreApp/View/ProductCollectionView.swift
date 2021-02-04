//
//  ProductCollectionView.swift
//  StoreApp
//
//  Created by 윤준수 on 2021/02/04.
//

import UIKit

class ProductCollectionView: UICollectionView {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.next?.touchesBegan(touches, with: event)
    }
}
