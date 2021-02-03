//
//  NetworkHandler.swift
//  StoreApp
//
//  Created by 윤준수 on 2021/02/01.
//

import Foundation
import UIKit

class NetworkHandler {
    private static let fileManager = MyFileManager()
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
//            print(products)
        }
        dataTask.resume()
    }

    class func getImage(url: URL, title: String, completionHandler: @escaping (Data) -> Void) {
        if let imageData = fileManager.getImageFromCache(imageUrl: url) {
            completionHandler(imageData)
        }
        let defaultSession = URLSession(configuration: .default)
        let downloadTask = defaultSession.downloadTask(with: url) { tempLocalURL, response, error in
            guard error == nil else {
                print("Error occur: \(String(describing: error))")
                return
            }

            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                return
            }

            guard let tempLocalURL = tempLocalURL else { return }
            fileManager.saveImageAtCahe(imageUrl: tempLocalURL, fileName: title)
            if let imageData = fileManager.getImageFromCache(imageUrl: tempLocalURL) {
                completionHandler(imageData)
            }
        }
        downloadTask.resume()
    }
}

protocol NetworkHandlerDelegate: class {
    func saveProducts(productType: ProductType, products: [Product])
}
