//
//  ImageCacheManager.swift
//  StoreApp
//
//  Created by 이청원 on 2021/02/03.
//

import UIKit

class ImageCacheManager {
    static let shared = NSCache<NSString, UIImage>()
        
    private init() {}
}
