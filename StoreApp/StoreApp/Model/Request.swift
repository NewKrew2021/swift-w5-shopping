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
    
    private let baseUrl = "http://public.codesquad.kr/jk/kakao-2021/"
    private let json = Json()
    
    func request(productType: ProductType) {
        let url = "\(baseUrl)\(productType.info.description).json"
        URLSession.shared.dataTask(with: URL(string: url)!) { (data,response,error) in
            guard error == nil && data != nil else {
                if let err = error {
                    print(err.localizedDescription)
                }
                return
            }
            
            DispatchQueue.main.async {
                let result = self.json.parsing(jsonData: data ?? Data())
                switch result {
                case .success(let resultData):
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "jsonParsing"),object: nil, userInfo: ["products" : resultData, "productTypeValue" : productType.rawValue])
                case .failure(let error):
                    print(error)
                }
            }
        }.resume()
    }
}
