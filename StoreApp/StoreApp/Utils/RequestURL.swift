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
    func requestHttp(){
        for iter in JsonFileName.jsonFileName {
            guard let url = URL(string: "http://public.codesquad.kr/jk/kakao-2021/\(iter.rawValue).json") else { return }

            SectionHeader.headerTitle.append(iter.rawValue)
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                guard let data = data else { return }
                DispatchQueue.main.async {
                    do {
                        self.decodingJsonData(iter: iter, data: data)
                    } catch {
                        let toast = Toast(text: iter.rawValue + "json 을 읽어올 수 없습니다.")
                        ToastView.appearance().font = UIFont.systemFont(ofSize: 13, weight: .bold)
                        toast.show()
                    }
                }
            }.resume()
        }
    }
    
    func decodingJsonData(iter: JsonFileName, data: Data) {
        if let decodeData = try? JSONDecoder().decode([Item].self, from : data){
            let userInfo: [AnyHashable: Any] = [iter.rawValue:decodeData]
            NotificationCenter.default.post(name: NSNotification.Name("saveItem"), object: self, userInfo: userInfo)
        }
    }
}
