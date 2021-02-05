//
//  DetailStoreItem.swift
//  StoreApp
//
//  Created by 이준형 on 2021/02/04.
//  Copyright © 2021 이준형. All rights reserved.
//

import Foundation
import UIKit

class DetailStoreItem {
    var detailItem : DetailItem?
    
    func downloadJson(productId: String, storeDomain: String){
        guard let url = URL(string: "https://store.kakao.com/a/\(storeDomain)/product/\(productId)/detail") else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let data = data else { return }
            self.decoding(data: data)
        }.resume()
    }
    
    func decoding(data: Data){
        DispatchQueue.main.async {
            do {
                if let decodeData = try? JSONDecoder().decode(DetailItem.self, from : data){
                    self.detailItem = decodeData
                    NotificationCenter.default.post(name: NSNotification.Name("saveDetailItem"), object: self, userInfo: nil)
                } else{
                    self.detailItem = nil
                }
            } catch {
            }
        }
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
    
    func getProductImage() -> UIImage {
        var tempImage : UIImage = UIImage()
        let url = detailItem?.data.previewImages![0]
        let name = URL(string: url!)!.query!
        if let cachedData = CacheStorage().retrieve(name) {
            tempImage = UIImage(data: cachedData)!
            
        } else {
            Downloader.downloadWithDataTask(from: url!, completionHandler: { response in
                switch response {
                case .success(let dataTemp):
                    tempImage = UIImage(data: dataTemp)!
                    DispatchQueue.main.async {
                        try? CacheStorage().save(name, dataTemp)
                    }
                case .failure:
                    DispatchQueue.main.async {
                        tempImage = self.presentGraySpace()
                    }
                }
            })
        }
        return tempImage
    }
    
    func getProductName() -> String {
        return self.detailItem?.data.name ?? ""
    }
    
    func getGroupDiscountedPrice() -> String {
        if let dc = self.detailItem?.data.price?.discountedPrice {
            return "톡딜가 \(dc)원"
        }
        return ""
    }
    
    func getOriginalPrice() -> String {
        if let dc = self.detailItem?.data.price?.standardPrice {
            return "바로 구매 \(dc)원"
        }
        return ""
    }
    func getStoreName() -> String {
        if let dc = self.detailItem?.data.store?.name {
            return "\(dc)"
        }
        return ""
    }
    
    func getDeliveryPrice() -> String {
        if let dc = self.detailItem?.data.delivery?.deliveryFeeType {
            if dc == "FREE" {
                return "배송비 무료"
            }
            if let dp = self.detailItem?.data.delivery?.deliveryFee {
                return "배송비 \(dp)원"
            }
        }
        return ""
    }
    
    func getNoticeTitle() -> String {
        if let dc = self.detailItem?.data.notices {
            if dc.count > 0 {
                return dc[0].title!
            }
        }
        return ""
    }
    
    func getNoticeCreateAt() -> String {
        if let dc = self.detailItem?.data.notices{
            if dc.count > 0 {
                return dc[0].createdAt!
            }
        }
        return ""
    }
    
    func getProductDescription() -> String {
        if let dc = self.detailItem?.data.dataDescription {
            return dc
        }
        return ""
    }
}
