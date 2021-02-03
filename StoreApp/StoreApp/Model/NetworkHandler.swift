//
//  NetworkHandler.swift
//  StoreApp
//
//  Created by 윤준수 on 2021/02/01.
//

import Foundation

class NetworkHandler {
    private static let baseURL: String = "http://public.codesquad.kr/jk/kakao-2021"
    private static let productURLs: [String] = ["/best.json", "/mask.json", "/grocery.json", "/fryingpan.json"]
    static var delegate: NetworkHandlerDelegate?

    class func getData(productType: ProductType) {
        // 세션 생성, 환경설정
        let defaultSession = URLSession(configuration: .default)

        guard let url = URL(string: "\(baseURL)\(productURLs[productType.rawValue])") else {
            print("URL is nil")
            return
        }

        // Request
        let request = URLRequest(url: url)

        // dataTask
        let dataTask = defaultSession.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            // getting Data Error
            guard error == nil else {
                print("Error occur: \(String(describing: error))")
                return
            }

            guard let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                return
            }

            let decoder = JsonDecoder()
            let products = decoder.parseData(data: data)
            delegate?.saveProducts(productType: productType, products: products)
        }
        dataTask.resume()
    }
}

protocol NetworkHandlerDelegate:class {
    func saveProducts(productType: ProductType, products: [Product])
}
