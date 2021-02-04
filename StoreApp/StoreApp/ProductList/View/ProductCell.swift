//
//  ProductCell.swift
//  StoreApp
//
//  Created by bean Milky on 2021/02/01.
//

import UIKit
import RxSwift
import RxCocoa

class ProductCell: UICollectionViewCell {
    static let identifier: String = "ProductCell"
    @IBOutlet var thumbnail: UIImageView!
    @IBOutlet var name: UILabel!
    @IBOutlet var originalPrice: UILabel!
    @IBOutlet var groupDiscountedPrice: UILabel!
    @IBOutlet var groupDiscountUserCount: UILabel!
    private var productViewModel: ProductCellViewModel?
    private let disposeBag = DisposeBag()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configure(viewModel: ProductCellViewModel) {
        productViewModel = viewModel
        name.text = viewModel.productName
        originalPrice.text = "톡딜가 \(viewModel.originalPrice)원"
        if let groupDiscountedPrice = viewModel.groupDiscountedPrice {
            self.groupDiscountedPrice.text = "\(groupDiscountedPrice)원"
        }
        groupDiscountUserCount.text = "현재 \(viewModel.groupDiscountUserCount)명 딜 참여중"
        viewModel.productImage
            .bind(to: thumbnail.rx.image)
            .disposed(by: disposeBag)
    }
    
    
}
