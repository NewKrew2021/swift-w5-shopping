//
//  ItemCollectionViewCell.swift
//  StoreApp
//
//  Created by 지현우 on 2021/02/01.
//

import UIKit

class ItemCollectionViewCell: UICollectionViewCell {
    // MARK: Internal

    @IBOutlet var imgView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var talkDealPriceLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var participantOfDealLabel: UILabel!

    private lazy var indicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.startAnimating()
        indicator.hidesWhenStopped = true
        return indicator
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        setIndicator()
        imgView.sizeToFit()
        backgroundColor = .white
    }

    func update(img: UIImage) {
        isLoading = false
        imgView.image = img
    }

    func update(title: String, price: Int, talkDealPrice: Int, numberOfParticipant: Int) {
        titleLabel.text = title
        priceLabel.text = "\(price)원"
        talkDealPriceLabel.text = "톡딜가 \(talkDealPrice)원"
        participantOfDealLabel.text = "현재 \(numberOfParticipant)명 딜 참여중"
    }

    func update(title: String, price: Int) {
        titleLabel.text = title
        priceLabel.text = "\(price)원"
        talkDealPriceLabel.isHidden = true
        participantOfDealLabel.isHidden = true
    }

    // MARK: Private

    private var isLoading: Bool {
        get {
            return indicator.isAnimating
        }
        set {
            if newValue {
                indicator.startAnimating()
            } else {
                indicator.stopAnimating()
            }
        }
    }

    private func setIndicator() {
        addSubview(indicator)
        indicator.centerYAnchor.constraint(equalTo: imgView.centerYAnchor).isActive = true
        indicator.centerXAnchor.constraint(equalTo: imgView.centerXAnchor).isActive = true
    }
}
