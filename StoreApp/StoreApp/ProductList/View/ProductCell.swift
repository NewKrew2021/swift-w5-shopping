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
    private let disposeBag = DisposeBag()
    private var productViewModel: ProductCellViewModel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func config(viewModel: ProductCellViewModel) {
        productViewModel = viewModel
        name.text = viewModel.productName
        viewModel.productImage
            .bind(to: thumbnail.rx.image)
            .disposed(by: disposeBag)
    }
    
    
}
