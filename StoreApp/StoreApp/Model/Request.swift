//
//  Request.swift
//  StoreApp
//
//  Created by 이청원 on 2021/02/01.
//

import Foundation

class Request {
    
    private let baseUrl = "http://public.codesquad.kr/jk/kakao-2021/"
    private let json = Json()
    
    init() {
        NotificationCenter.default.addObserver(self,
                    selector: #selector(errorHandling),
                    name: NSNotification.Name(rawValue: "jsonErrorHandling"),
                    object: nil)
    }
    
    func request(productType: ProductType) {
        let url = "\(baseUrl)\(productType)"
        URLSession.shared.dataTask(with: URL(string: url)!) { (data,response,error) in
            guard error == nil && data != nil else {
                if let err = error {
                    print(err.localizedDescription)
                }
                return
            }
            DispatchQueue.main.async {
                self.json.parsing(jsonData: data ?? Data(), productType: productType)
            }
        }.resume()
    }
    
    @objc func errorHandling(_ notification:Notification) {
        print(notification.userInfo?["error"] ?? "error")
    }
}
