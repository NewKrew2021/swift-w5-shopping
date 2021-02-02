//
//  MainViewModel.swift
//  StoreApp
//
//  Created by 지현우 on 2021/02/01.
//

import Foundation

class MainViewModel {
    var items: [[Item]] = []

    var flags: [Bool] = [false, false, false, false]

    func addItems(items: [Item]) {
        self.items.append(items)
    }

    subscript(section: Int, item: Int) -> Item {
        items[section][item]
    }
}
