//
//  myDetailViewController.swift
//  StoreApp
//
//  Created by 이준형 on 2021/02/03.
//  Copyright © 2021 이준형. All rights reserved.
//

import Foundation
import UIKit

class myDetailViewController:  UIViewController {
    
    @IBOutlet weak var myDetailView: myDetailView!
    
    var productId : String!
    var storeDomain : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.registerObserver()
        self.navigationController?.title = "손안에 쇼핑"
        myDetailView.downloadJson(productId: productId, storeDomain: storeDomain)
    }
    
    func initVC(productId : String, storeDomain : String){
        self.productId = productId
        self.storeDomain = storeDomain
    }
    
    @objc func showToastDetail(notification: Notification){
        guard let userInfo = notification.userInfo as NSDictionary? as? [String: String] else {return}
        showToast(text: userInfo.values.first!)
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func cantLoadJson(notification: Notification){
        showToast(text: "페이지를 읽어올 수 없습니다.")
        self.navigationController?.popViewController(animated: true)
    }
}
