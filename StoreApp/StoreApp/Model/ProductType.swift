//
//  ProductType.swift
//  StoreApp
//
//  Created by 이청원 on 2021/02/01.
//

import Foundation

enum ProductType : Int, CustomStringConvertible, CaseIterable {
    case best, mask, grocery, fryingpan
    
    var description: String {
        switch self {
        case .best: return "best.json"
        case .mask: return "mask.json"
        case .grocery: return "grocery.json"
        case .fryingpan: return "fryingpan.json"
        }
    }
}
