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
    
    var count : Int{
        return allItems.count 
    }
    
    func count(index : Int) -> Int{
        return allItems[JsonFileName.jsonFileName[index]]!.count
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
    
    private func presentGraySpace() -> UIImage{
        let emptyView = UIView(frame: CGRect.zero)
        emptyView.widthAnchor.constraint(equalToConstant: 100)
        emptyView.heightAnchor.constraint(equalTo: emptyView.widthAnchor, multiplier: 1)
        emptyView.backgroundColor = .white
        emptyView.setNeedsLayout()
        let renderer = UIGraphicsImageRenderer(size: emptyView.frame.size)
        let emptyImage = renderer.image(actions: { _ in
            emptyView.drawHierarchy(in: emptyView.bounds, afterScreenUpdates: true)
        })
        return emptyImage
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
                    try? CacheStorage().save(name, dataTemp)
                case .failure:
                    DispatchQueue.main.async {
                        tempImage = self.presentGraySpace()
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
            return "톡딜가 : " + String(dc) + "원"
        }
        return ""
    }
    
    func getOriginalPrice(indexPath: IndexPath) -> String {
        if let dc = self[indexPath].originalPrice {
            return String(dc) + "원"
        }
        return ""
    }
    
    func getGroupDiscountUserCount(indexPath: IndexPath) -> String {
        if let dc = self[indexPath].groupDiscountUserCount {
            return "현재 "+String(dc) + "명 딜 참여중"
        }
        return ""
        
    }
}


