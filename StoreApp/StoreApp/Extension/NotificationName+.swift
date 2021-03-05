//
//  NotificationName.swift
//  StoreApp
//
//  Created by 이준형 on 2021/02/05.
//  Copyright © 2021 이준형. All rights reserved.
//

import Foundation
extension Notification.Name {
    static let showToast = Notification.Name("showToast")
    static let saveItemCollection = Notification.Name("saveItemCollection")
    static let cantLoadJson = Notification.Name("cantLoadJson")
    static let reloadItem = Notification.Name("reloadItem")
    
    static let saveDetailItem = Notification.Name("saveDetailItem")
    static let reloadDetailItem = Notification.Name("reloadDetailItem")
    static let showToastDetail = Notification.Name("showToastDetail")
}
