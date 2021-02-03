//
//  StoreItems.swift
//  StoreApp
//
//  Created by herb.salt on 2021/02/02.
//  Copyright © 2021 com.kakaocorp. All rights reserved.
//

import Foundation

class StoreItems {
    
    private(set) var bests = [StoreItem]()
    private(set) var masks = [StoreItem]()
    private(set) var grocerys = [StoreItem]()
    private(set) var fryingpans = [StoreItem]()
    
    func addData(category: String, items: [StoreItem]) {
        
        switch category {
        case "best":
            for item in items {
                self.bests.append(item)
            }
        case "mask":
            for item in items {
                self.masks.append(item)
            }
        case "grocery":
            for item in items {
                self.grocerys.append(item)
            }
        case "fryingpan":
            for item in items {
                self.fryingpans.append(item)
            }
        default:
            return
        }
        
    }
    
}
