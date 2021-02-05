//
//  JsonFileName.swift
//  StoreApp
//
//  Created by 이준형 on 2021/02/05.
//  Copyright © 2021 이준형. All rights reserved.
//

import Foundation

enum JsonFileName : String {
    case best = "best"
    case mask = "mask"
    case grocery = "grocery"
    case fryingpan = "fryingpan"
    
    static let jsonFileName = [best, mask, grocery, fryingpan]
}
