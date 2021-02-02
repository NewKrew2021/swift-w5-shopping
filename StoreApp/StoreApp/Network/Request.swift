//
//  Request.swift
//  StoreApp
//
//  Created by 지현우 on 2021/02/01.
//

import Foundation

let DidReceiveItemsNotification = Notification.Name("DidReceiveItems")

// MARK: - Request

class Request {
    // MARK: Internal

    static let shared = Request()

    func requestItem(type: String) {
        guard let url = URL(string: "\(base_url)\(type).json") else { return }

        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: url) { data, _, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }

            guard let data = data else { return }
            
            
            NotificationCenter.default.post(name: DidReceiveItemsNotification, object: nil, userInfo: ["Items": Decoder.parseData(data: data)])

            
        }
        dataTask.resume()
    }

    // MARK: Private

    private let base_url = "http://public.codesquad.kr/jk/kakao-2021/"
}
