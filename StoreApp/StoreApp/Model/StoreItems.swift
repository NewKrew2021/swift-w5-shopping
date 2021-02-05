//
//  StoreItems.swift
//  StoreApp
//
//  Created by 이준형 on 2021/02/01.
//  Copyright © 2021 이준형. All rights reserved.
//

import Foundation
import UIKit

class StoreItems {
    private var allItems : [JsonFileName: [Item]] = [JsonFileName.best : []]
    
    var count : Int {
        return allItems.count 
    }
    
    func count(index : Int) -> Int {
        if let arr = allItems[JsonFileName.jsonFileName[index]] {
            return arr.count
        }
        return 0
    }
    
    subscript(indexPath: IndexPath) -> Item {
        return allItems[JsonFileName.jsonFileName[indexPath[0]]]![indexPath[1]]
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
    
    func getProductImage(indexPath: IndexPath) -> UIImage {
        var tempImage : UIImage = UIImage()
        let url = self[indexPath].productImage
        let name = URL(string: url)!.query!
        if let cachedData = CacheStorage().retrieve(name) {
                tempImage = UIImage(data: cachedData)!
        } else {
            Downloader.downloadWithDataTask(from: url, completionHandler: { response in
                switch response {
                case .success(let dataTemp):
                    tempImage = UIImage(data: dataTemp)!
                    DispatchQueue.main.async {
                        try? CacheStorage().save(name, dataTemp)
                    }
                case .failure:
                    DispatchQueue.main.async {
                        tempImage = UIImage()
                    }
                }
            })
        }
        return tempImage
    }
    
    func getProductName(indexPath: IndexPath) -> String {
        return self[indexPath].productName
    }
    
    func getGroupDiscountedPrice(indexPath: IndexPath) -> String {
        if let dc = self[indexPath].groupDiscountedPrice {
            return "톡딜가 : \(dc)원"
        }
        return ""
    }
    
    func getOriginalPrice(indexPath: IndexPath) -> String {
        if let dc = self[indexPath].originalPrice {
            return "\(dc)원"
        }
        return ""
    }
    
    func getGroupDiscountUserCount(indexPath: IndexPath) -> String {
        if let dc = self[indexPath].groupDiscountUserCount {
            return "현재 \(dc)명 딜 참여중"
        }
        return ""
    }
    
    func getProductId(indexPath: IndexPath) -> String {
        if let dc = self[indexPath].productId {
            return "\(dc)"
        }
        return ""
    }
    
    func getStoreDomain(indexPath: IndexPath) -> String {
        return self[indexPath].storeDomain 
    }
}




