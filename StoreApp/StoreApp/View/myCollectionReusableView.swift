//
//  myCollectionReusableView.swift
//  StoreApp
//
//  Created by 이준형 on 2021/02/01.
//  Copyright © 2021 이준형. All rights reserved.
//

import UIKit

class SectionHeader {
    static var headerTitle : [String] = []
}

class myCollectionReusableView: UICollectionReusableView {
    var header = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initHeader()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initHeader()
        
    }
    func initHeader() {
        self.addSubview(header)
        header.clipsToBounds = true
        header.contentMode = .scaleToFill
        header.backgroundColor = .lightGray
        header.translatesAutoresizingMaskIntoConstraints = false
        header.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        header.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 1).isActive = true
        header.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 1).isActive = true
        header.sizeToFit()
        header.textAlignment = .center

        header.font = UIFont.systemFont(ofSize: 15, weight: .bold)
    }
    
    func setHeader(indexPath: IndexPath){
        self.header.text = SectionHeader.headerTitle[indexPath[0]]
    }
}
