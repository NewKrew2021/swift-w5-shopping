//
//  Network.swift
//  StoreApp
//
//  Created by 이청원 on 2021/02/03.
//

import Foundation

struct Network {
    private let request = Request()
    func getData() {
        for productType in ProductType.allCases {
            request.request(productType: productType)
        }
    }
}
