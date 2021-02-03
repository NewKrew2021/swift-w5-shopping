//
//  MainViewModel.swift
//  StoreApp
//
//  Created by 지현우 on 2021/02/01.
//

import UIKit

class MainViewModel {
    var items: [[Item]] = []

    var flags: [Bool] = [false, false, false, false]

    func addItems(items: [Item]) {
        self.items.append(items)
    }
    
    func hasItems(at section: Int) -> Bool{
        flags[section]
    }

    subscript(section: Int, item: Int) -> Item {
        items[section][item]
    }
    
}
