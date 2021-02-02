//
//  JsonData.swift
//  StoreApp
//
//  Created by herb.salt on 2021/02/02.
//  Copyright © 2021 com.kakaocorp. All rights reserved.
//

import Foundation

class JsonData {
    
    var category = ""
    var storeItems = [StoreItem]()
    
    init(_ category: String, _ storeItems: [StoreItem]) {
        self.category = category
        self.storeItems = storeItems
    }
    
}
