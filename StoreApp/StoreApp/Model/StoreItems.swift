//
//  StoreItems.swift
//  StoreApp
//
//  Created by 이준형 on 2021/02/01.
//  Copyright © 2021 이준형. All rights reserved.
//

import Foundation
import UIKit

enum JsonFileName : String {
    case best = "best"
    case mask = "mask"
    case grocery = "grocery"
    case fryingpan = "fryingpan"
    
    static let jsonFileName = [best, mask, grocery, fryingpan]
}

class StoreItems {
    private var allItems : [JsonFileName: [Item]] = [JsonFileName.best : []]
    
    var count : Int {
        return allItems.count 
    }
    
    subscript(type : JsonFileName, index : Int) -> Item {
        return allItems[type]![index]
    }
    
    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(reloadItems(notification:)), name: NSNotification.Name("saveItem"), object: nil)
    }
    
    @objc func reloadItems(notification: Notification) {
        guard let userInfo = notification.userInfo as NSDictionary? as? [String: [Item]] else {return}
        switch userInfo.keys.first! {
        case "best":
            allItems[.best] = userInfo.values.first!
        case "mask":
            allItems[.mask] = userInfo.values.first!
        case "grocery":
            allItems[.grocery] = userInfo.values.first!
        case "fryingpan":
            allItems[.fryingpan] = userInfo.values.first!
        default:
            return
        }
        NotificationCenter.default.post(name: NSNotification.Name("reloadItem"), object: self, userInfo: nil)
    }
}


