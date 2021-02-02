//
//  Downloader.swift
//  StoreApp
//
//  Created by 이준형 on 2021/02/02.
//  Copyright © 2021 이준형. All rights reserved.
//

import UIKit

class Downloader {
    typealias AfterTask = (Result) -> Void
    
    enum Result {
        case success(Data)
        case failure(NetworkError)
    }

    static func downloadWithDataTask(from urlString: String, completionHandler: @escaping AfterTask) {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if error != nil {
                completionHandler(.failure(NetworkError.loadFail))
            } else {
                guard let data = data else { return }
                completionHandler(.success(data))
            }
        }.resume()
    }

    static func downloadToGlobalQueue(from urlString: String, qos: DispatchQoS.QoSClass,
                                      completionHandler: @escaping AfterTask) {
        guard let url = URL(string: urlString) else { return }
        DispatchQueue.global(qos: qos).async(execute: {
            do {
                let data = try Data(contentsOf: url)
                completionHandler(.success(data))
            } catch {
                completionHandler(.failure(NetworkError.loadFail))
            }
        })
    }
}

enum NetworkError: Error {
    case connectionDisable
    case loadFail
    case jsonDecodeFail
    var alert: (title: String, message: String) {
        switch self {
        case .connectionDisable: return ("네트워크 상태가 원활하지 않습니다.", "인터넷 연결을 확인해주세요.")
        case .loadFail: return ("화면을 불러오지 못했어요.", "인터넷 연결을 확인해주세요.")
        case .jsonDecodeFail: return ("주문 실패했습니다..", "자세한 사항은 고객센터에 문의해주세요.")
        }
    }
}
