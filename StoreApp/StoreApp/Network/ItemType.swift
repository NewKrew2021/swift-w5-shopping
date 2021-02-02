//
//  ItemType.swift
//  StoreApp
//
//  Created by 지현우 on 2021/02/01.
//

import Foundation

enum ItemType: Int, CaseIterable{
    case best
    case mask
    case grocery
    case fryingpan
    
    func getString() -> String{
        switch self {
        case .best:
            return "best"
        case .mask:
            return "mask"
        case .grocery:
            return "grocery"
        case .fryingpan:
            return "fryingpan"
        }
    }
    
}

