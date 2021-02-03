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
        contentView.sizeToFit()
    }
    
    func initProductImage() {
        contentView.addSubview(productImage)
        productImage.clipsToBounds = true
        productImage.contentMode = .scaleToFill
        productImage.backgroundColor = .brown
        productImage.translatesAutoresizingMaskIntoConstraints = false
        productImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 1).isActive = true
        productImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        productImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        productImage.heightAnchor.constraint(equalToConstant: contentView.frame.height * 0.7).isActive = true
        productImage.sizeToFit()
    }
    
    func initProduntName() {
        contentView.addSubview(productName)
        productName.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        productName.preferredMaxLayoutWidth = frame.width
        productName.lineBreakMode = .byTruncatingTail
        productName.numberOfLines = 2
        productName.translatesAutoresizingMaskIntoConstraints = false
        productName.topAnchor.constraint(equalTo: productImage.bottomAnchor, constant: 1).isActive = true
        productName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        productName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        productName.sizeToFit()
    }
    
    func initGroupDiscountedPrice() {
        contentView.addSubview(groupDiscountedPrice)
        groupDiscountedPrice.font = UIFont.systemFont(ofSize: 13)
        groupDiscountedPrice.translatesAutoresizingMaskIntoConstraints = false
        groupDiscountedPrice.topAnchor.constraint(equalTo: productName.bottomAnchor, constant: 1).isActive = true
        groupDiscountedPrice.leadingAnchor.constraint(equalTo: productName.leadingAnchor, constant: 1).isActive = true
        groupDiscountedPrice.sizeToFit()
    }
    
    func initOriginalPrice() {
        contentView.addSubview(originalPrice)
        originalPrice.font = UIFont.systemFont(ofSize: 13, weight: .ultraLight)
        originalPrice.translatesAutoresizingMaskIntoConstraints = false
        originalPrice.topAnchor.constraint(equalTo: groupDiscountedPrice.topAnchor, constant: 1).isActive = true
        originalPrice.leadingAnchor.constraint(equalTo: groupDiscountedPrice.trailingAnchor, constant: 1).isActive = true
        originalPrice.sizeToFit()
    }
    
    func initGroupDiscountUserCount() {
        contentView.addSubview(groupDiscountUserCount)
        groupDiscountUserCount.font = UIFont.systemFont(ofSize: 13)
        groupDiscountUserCount.translatesAutoresizingMaskIntoConstraints = false
        groupDiscountUserCount.topAnchor.constraint(equalTo: groupDiscountedPrice.bottomAnchor, constant: 1).isActive = true
        groupDiscountUserCount.leadingAnchor.constraint(equalTo: productName.leadingAnchor, constant: 1).isActive = true
        groupDiscountUserCount.sizeToFit()
    }
    
    func setSubViews(indexPath: IndexPath, data: StoreItems) {
        productImage.image = data.getProductImage(indexPath: indexPath)
        productName.text = data.getProductName(indexPath: indexPath)
        groupDiscountedPrice.text = data.getGroupDiscountedPrice(indexPath: indexPath)
        originalPrice.text = data.getOriginalPrice(indexPath: indexPath)
        groupDiscountUserCount.text = data.getGroupDiscountUserCount(indexPath: indexPath)
        
    }
}
