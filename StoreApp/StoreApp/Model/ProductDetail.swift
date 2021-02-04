//
//  ProductDetail.swift
//  StoreApp
//
//  Created by 윤준수 on 2021/02/04.
//

import Foundation

struct ProductDetail {
    var previewImages: [URL]
    var description: String
    var review: Review
    var talkDeal : TalkDeal?
    var store: Store
    var delivery: Delivery
    var notices: Notices
    
    struct Review {
        var totalProductStarRating: Float
        var reviewCount: Int
        
    }
    
    struct TalkDeal {
        var status: String
        var discountPrice: Int
        enum Status: String {
            case ON_SALE
        }
    }
    
    struct Store {
        var name: String
    }
    
    struct Delivery {
        var deliveryFeeType: DeliveryFeeType
        var deliveryFee: Int
        
        enum DeliveryFeeType: String {
            case Free
        }
    }
    
    struct Notices {
        var title: String
        var createAt: String
    }
}
