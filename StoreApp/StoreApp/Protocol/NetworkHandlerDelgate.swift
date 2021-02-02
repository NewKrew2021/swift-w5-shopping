//
//  NetworkHandlerDelgate.swift
//  StoreApp
//
//  Created by 윤준수 on 2021/02/02.
//

import Foundation

protocol NetworkHandlerDelegate:class {
    func saveProducts(productType: ProductType, products: [Product])
}
