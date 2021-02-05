//
//  myDetailViewController.swift
//  StoreApp
//
//  Created by 이준형 on 2021/02/03.
//  Copyright © 2021 이준형. All rights reserved.
//

import Foundation
import UIKit
import Toaster
import WebKit

class myDetailViewController:  UIViewController {
    
    @IBOutlet weak var myDetailView: myDetailView!
    var productId : String!
    var storeDomain : String!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.title = "손안에 쇼핑"
        myDetailView.downloadJson(productId: productId, storeDomain: storeDomain)
        
        NotificationCenter.default.addObserver(self, selector: #selector(showToastDetail(notification:)), name: NSNotification.Name("showToastDetail"), object: nil)
    }
    
    func initVC(productId : String, storeDomain : String){
        self.productId = productId
        self.storeDomain = storeDomain
    }
    
    @objc func showToastDetail(notification: Notification){
        guard let userInfo = notification.userInfo as NSDictionary? as? [String: String] else {return}
        let toast = Toast(text: userInfo.values.first!)
        ToastView.appearance().font = UIFont.systemFont(ofSize: 13, weight: .bold)
        toast.show()
    }
    
    
    
}
