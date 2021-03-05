//
//  ViewController+.swift
//  StoreApp
//
//  Created by 이준형 on 2021/02/05.
//  Copyright © 2021 이준형. All rights reserved.
//

import Foundation
import Toaster

extension UIViewController {
    func showToast(text : String){
         let toast = Toast(text: text)
        ToastView.appearance().font = UIFont.systemFont(ofSize: 13, weight: .bold)
        toast.show()
    }
}
