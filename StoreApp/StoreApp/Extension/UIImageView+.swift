//
//  UIImageView+.swift
//  StoreApp
//
//  Created by 윤준수 on 2021/02/04.
//

import Foundation
import UIKit

extension UIImageView {
    func setImageByUrl(url: URL) {
        NetworkHandler.getImage(url: url) { imageData in
            DispatchQueue.main.async {
                self.image = UIImage(data: imageData)
            }
        }
    }
}
