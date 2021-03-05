//
//  myDetailViewController.swift
//  StoreApp
//
//  Created by 이준형 on 2021/02/06.
//  Copyright © 2021 이준형. All rights reserved.
//

import Foundation

extension myDetailViewController {
    NotificationCenter.default.addObserver(self, selector: #selector(showToastDetail(notification:)), name: .showToastDetail, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(cantLoadJson(notification:)), name: .cantLoadJson, object: nil)
}
