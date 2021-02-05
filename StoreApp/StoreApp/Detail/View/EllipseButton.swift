//
//  EclipseButton.swift
//  StoreApp
//
//  Created by 지현우 on 2021/02/04.
//

import UIKit

// MARK: - EllipseButton

class EllipseButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.makeEllipse()
        setInset()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.makeEllipse()
        setInset()
    }
}

extension EllipseButton {
    func makeEllipse() {
        self.layer.borderWidth = 1
        self.layer.cornerRadius = self.frame.size.height/5
        self.clipsToBounds = true
    }
    func setInset(){
        self.contentEdgeInsets = UIEdgeInsets(top: 1, left: 10, bottom: 1, right: 10)
    }
}
