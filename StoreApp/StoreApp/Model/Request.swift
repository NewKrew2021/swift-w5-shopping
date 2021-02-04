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
}
