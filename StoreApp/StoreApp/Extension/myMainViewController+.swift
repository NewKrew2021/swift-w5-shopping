//
//  ViewContoller+.swift
//  StoreApp
//
//  Created by 이준형 on 2021/02/06.
//  Copyright © 2021 이준형. All rights reserved.
//

import Foundation

extension myMainViewController {
    func registerObserver(){
        NotificationCenter.default.addObserver(self, selector: #selector(saveItemCollection(notification:)), name: .saveItemCollection, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reloadItems(notification:)), name: .reloadItem, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(showToast(notification:)), name: .showToast, object: nil)
    }
}
