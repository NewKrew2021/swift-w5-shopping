//
//  sectionHeader.swift
//  StoreApp
//
//  Created by 윤준수 on 2021/02/01.
//

import UIKit

class SectionHeader: UICollectionViewCell {
    @IBOutlet var title: UILabel!

    func setTitle(title: String) {
        self.title.text = title
    }
}
