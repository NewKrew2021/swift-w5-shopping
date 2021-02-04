//
//  ProductType.swift
//  StoreApp
//
//  Created by 이청원 on 2021/02/01.
//

import Foundation

enum ProductType : Int, CaseIterable {
    case best, mask, grocery, fryingpan
    
    var info : (description: String, korDescription: String) {
        switch self {
        case .best: return ("best", "베스트")
        case .mask: return ("mask", "마스크")
        case .grocery: return ("grocery", "잡화")
        case .fryingpan: return ("fryingpan", "프라이팬")
        }
    }
}
