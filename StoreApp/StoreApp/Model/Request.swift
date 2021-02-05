//
//  Request.swift
//  StoreApp
//
//  Created by 이청원 on 2021/02/01.
//

import Foundation

class Request {
    
    enum Result<Success, Failure: Error> {
        case success(Success)
        case failure(Failure)
    }
    
    private let json = Json()
    
    func requestProduct(productType: ProductType) {
        let baseUrl = "http://public.codesquad.kr/jk/kakao-2021/"
        let url = "\(baseUrl)\(productType.info.description).json"
        URLSession.shared.dataTask(with: URL(string: url)!) { (data,response,error) in
            guard error == nil && data != nil else {
                if let err = error {
                    print(err.localizedDescription)
                }
                return
            }
            
            DispatchQueue.main.async {
                let result = self.json.parsingProduct(jsonData: data ?? Data())
                switch result {
                case .success(let resultData):
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "jsonParsing"),object: nil, userInfo: ["products" : resultData, "productTypeValue" : productType.rawValue])
                case .failure(let error):
                    print(error)
                }
            }
        }.resume()
    }
    
    func requestProductDetail(storeDomain : String, productId : Int) {
        let url = "https://store.kakao.com/a/\(storeDomain)/product/\(productId)/detail"
        URLSession.shared.dataTask(with: URL(string: url)!) { (data, response, error) in
            guard error == nil && data != nil else {
                if let err = error {
                    print(err.localizedDescription)
                }
                return
            }
            
            DispatchQueue.main.async {
                let result = self.json.parsingProductDetail(jsonData: data ?? Data())
                switch result {
                case .success(let resultData):
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "jsonParsingProductDetail"),object: nil, userInfo: ["productDetail" : resultData])
                case .failure(let error):
                    print(error)
                }
            }
        }.resume()
    }
    
    func requestPostPurchase(text: String) {
        guard let url = URL(string:"https://hooks.slack.com/services/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") else { return }
        let parameterDictionary = ["text" : text]
        var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
            guard let httpBody = try? JSONSerialization.data(withJSONObject: parameterDictionary, options: []) else {
                return
            }
            request.httpBody = httpBody
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard error == nil && data != nil else {
                if let err = error {
                    print(err.localizedDescription)
                }
                return
            }
        }.resume()
    }
}
