//
//  Request.swift
//  StoreApp
//
//  Created by 이청원 on 2021/02/01.
//

import Foundation

struct Request {
    
    private let baseUrl = "http://public.codesquad.kr/jk/kakao-2021/"
    private let json = Json()
    
    func request(productType: ProductType) {
        let url = "\(baseUrl)\(productType)"
        URLSession.shared.dataTask(with: URL(string: url)!) { (data,response,error) in
            guard error == nil && data != nil else {
                if let err = error {
                    print(err.localizedDescription)
                }
                return
            }
            json.parsing(jsonData: data ?? Data())
        }.resume()
    }
}
