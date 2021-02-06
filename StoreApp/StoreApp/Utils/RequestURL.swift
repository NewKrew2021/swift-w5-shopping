//
//  Request.swift
//  StoreApp
//
//  Created by 이준형 on 2021/02/02.
//  Copyright © 2021 이준형. All rights reserved.
//

import Foundation
import Toaster

class RequestURL {
    func requestDownloadURL(url : String, type : Notification.Name, dataType: JsonFileName) {
        guard let url = URL(string: url) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            self.decoding(data: data, type: type, dataType: dataType)
        }.resume()
    }
    
    func decoding(data : Data, type: Notification.Name, dataType: JsonFileName)  {
        DispatchQueue.main.async {
            do {
                if type == .saveItemCollection {
                    if let decodeData = try? JSONDecoder().decode([Item].self, from : data){
                        let userInfo: [AnyHashable: Any] = [dataType.rawValue:decodeData]

                        NotificationCenter.default.post(name: type, object: self, userInfo: userInfo)
                    }
                }
                else if type == .saveDetailItem {
                    if let decodeData = try? JSONDecoder().decode(DetailItem.self, from : data){
                        let userInfo: [AnyHashable: Any] = ["data":decodeData]
                        NotificationCenter.default.post(name: type, object: self, userInfo: userInfo)
                    }
                }
            } catch {}
        }
    }
}
