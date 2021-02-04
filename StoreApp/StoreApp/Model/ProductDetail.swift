//
//  ProductDetail.swift
//  StoreApp
//
//  Created by 이청원 on 2021/02/04.
//

import Foundation

struct ProductDetail: Codable {
    let data : Data
    
    struct Data : Codable {
        let previewImages : [String]
        let price : Price
        let review : Review
        let status : String
        let store : Store
        let delivery : Delivery
        let notices : [Notice]
        let description : String
        
        struct Price : Codable {
            let discountedPrice : Int
        }
        
        struct Review : Codable {
            let totalProductStarRating : Double
            let reviewCount : Int
        }
        
        struct Store : Codable {
            let name : String
        }
        
        struct Delivery : Codable {
            let deliveryFeeType : String
            let deliveryFee : Int
        }
        
        struct Notice : Codable {
            let title : String
            let createdAt : String
        }
    }
}
