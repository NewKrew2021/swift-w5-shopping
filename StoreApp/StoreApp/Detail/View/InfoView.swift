//
//  InfoView.swift
//  StoreApp
//
//  Created by 지현우 on 2021/02/05.
//

import UIKit

class InfoView: UIView {
    // MARK: Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        addUIComponents()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addUIComponents()
    }

    // MARK: Private

    private var storeNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.text = "손안에쇼핑"
        return label
    }()

    private var deliveryFeeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "배송비 무료"
        return label
    }()

    private var deliveryInfoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "[필수]........"
        return label
    }()

    private var numberOfDealLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "딜 참여 000명"
        return label
    }()
    
    private func addStoreNameLabel(){
        self.addSubview(storeNameLabel)
        storeNameLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        storeNameLabel.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
    }
    
    private func addNumberOfDealLabel(){
        self.addSubview(numberOfDealLabel)
        numberOfDealLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        numberOfDealLabel.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
    }
    
    private func addDeliveryFeeLabel(){
        self.addSubview(deliveryFeeLabel)
        deliveryFeeLabel.topAnchor.constraint(equalTo: storeNameLabel.bottomAnchor, constant: 5).isActive = true
        deliveryFeeLabel.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
    }
    
    private func addDeliveryInfoLabel(){
        self.addSubview(deliveryInfoLabel)
        deliveryInfoLabel.topAnchor.constraint(equalTo: deliveryFeeLabel.bottomAnchor,constant: 10).isActive = true
        deliveryInfoLabel.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        deliveryInfoLabel.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
    }
    
    private func addUIComponents(){
        addStoreNameLabel()
        addNumberOfDealLabel()
        addDeliveryFeeLabel()
        addDeliveryInfoLabel()
    }
    
}
