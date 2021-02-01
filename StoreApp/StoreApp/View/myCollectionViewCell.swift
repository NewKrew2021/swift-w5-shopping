//
//  myCollectionViewCell.swift
//  StoreApp
//
//  Created by 이준형 on 2021/02/01.
//  Copyright © 2021 이준형. All rights reserved.
//

import UIKit

class myCollectionViewCell: UICollectionViewCell {
    var productImage: UIImageView = UIImageView()
    var productName: UILabel = UILabel()
    var groupDiscountedPrice = UILabel()
    var originalPrice = UILabel()
    var groupDiscountUserCount = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initProductImage()
        initProduntName()
        initGroupDiscountedPrice()
        initOriginalPrice()
        initGroupDiscountUserCount()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initProductImage()
        initProduntName()
        initGroupDiscountedPrice()
        initOriginalPrice()
        initGroupDiscountUserCount()
        
    }
    func initProductImage() {
        contentView.addSubview(productImage)
        productImage.clipsToBounds = true
        productImage.contentMode = .scaleToFill
        productImage.backgroundColor = .brown
        productImage.translatesAutoresizingMaskIntoConstraints = false
        productImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 1).isActive = true
        productImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 1).isActive = true
        productImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -1).isActive = true
        productImage.heightAnchor.constraint(equalToConstant: contentView.frame.height * 0.65).isActive = true
        productImage.sizeToFit()
    }
    
    func initProduntName() {
        contentView.addSubview(productName)
        productName.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        productName.preferredMaxLayoutWidth = frame.width
        productName.lineBreakMode = .byTruncatingTail
        productName.numberOfLines = 2
        productName.translatesAutoresizingMaskIntoConstraints = false
        productName.topAnchor.constraint(equalTo: productImage.bottomAnchor, constant: 1).isActive = true
        productName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 1).isActive = true
        productName.sizeToFit()
    }
    
    
    func initGroupDiscountedPrice() {
        contentView.addSubview(groupDiscountedPrice)
        groupDiscountedPrice.font = UIFont.systemFont(ofSize: 15)
        groupDiscountedPrice.translatesAutoresizingMaskIntoConstraints = false
        groupDiscountedPrice.topAnchor.constraint(equalTo: productName.bottomAnchor, constant: 1).isActive = true
        groupDiscountedPrice.leadingAnchor.constraint(equalTo: productName.leadingAnchor, constant: 1).isActive = true
        groupDiscountedPrice.sizeToFit()
    }
    
    func initOriginalPrice() {
        contentView.addSubview(originalPrice)
        originalPrice.font = UIFont.systemFont(ofSize: 15, weight: .ultraLight)
        originalPrice.translatesAutoresizingMaskIntoConstraints = false
        originalPrice.topAnchor.constraint(equalTo: groupDiscountedPrice.topAnchor).isActive = true
        originalPrice.leadingAnchor.constraint(equalTo: groupDiscountedPrice.trailingAnchor, constant: 1 * 10).isActive = true
        originalPrice.sizeToFit()
    }
    
    func initGroupDiscountUserCount() {
        contentView.addSubview(groupDiscountUserCount)
        groupDiscountUserCount.font = UIFont.systemFont(ofSize: 15)
        groupDiscountUserCount.translatesAutoresizingMaskIntoConstraints = false
        groupDiscountUserCount.topAnchor.constraint(equalTo: productName.bottomAnchor, constant: 1).isActive = true
        groupDiscountUserCount.leadingAnchor.constraint(equalTo: originalPrice.trailingAnchor, constant: 1 * 10).isActive = true
        groupDiscountUserCount.sizeToFit()
    }
    
    
    func setSubViews(indexPath: IndexPath, data: [[Item]]) {
        
        let url = URL(string: data[indexPath[0]][indexPath[1]].productImage)
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url!)
            DispatchQueue.main.async {
                self.productImage.image = UIImage(data: data!)
            }
        }
        
        productName.text = data[indexPath[0]][indexPath[1]].productName
        
        if let dc = data[indexPath[0]][indexPath[1]].groupDiscountedPrice {
            groupDiscountedPrice.text = "톡딜가 : " + String(dc) + "원"
        }
        else {
            groupDiscountedPrice.text = ""
        }
        
        if let dc = data[indexPath[0]][indexPath[1]].originalPrice {
            originalPrice.text = String(dc) + "원"
        }
        else {
            originalPrice.text = ""
        }

        if let dc = data[indexPath[0]][indexPath[1]].groupDiscountUserCount {
            groupDiscountUserCount.text = "현재 "+String(dc) + "명 딜 참여중"
        }
        else {
            groupDiscountUserCount.text = ""
        }
    }
}
