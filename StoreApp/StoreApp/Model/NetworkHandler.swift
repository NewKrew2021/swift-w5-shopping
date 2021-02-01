//
//  NetworkHandler.swift
//  StoreApp
//
//  Created by 윤준수 on 2021/02/01.
//

import Foundation

class NetworkHandler {
    class func getData(resource: String) {
        // 세션 생성, 환경설정
        let defaultSession = URLSession(configuration: .default)

        guard let url = URL(string: "\(resource)") else {
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
            let jsonArray = decoder.parseData(data: data)
            // 원하는 작업
        }
        dataTask.resume()
    }
}
