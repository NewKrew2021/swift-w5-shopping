//
//  Request.swift
//  StoreApp
//
//  Created by 지현우 on 2021/02/01.
//

import Foundation

let DidReceiveItemsNotification = Notification.Name("DidReceiveFriends")

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

            do {
                let items = try JSONDecoder().decode([Item].self, from: data)
                NotificationCenter.default.post(name: DidReceiveItemsNotification, object: nil, userInfo: ["Items": items])
            } catch let DecodingError.keyNotFound(key, context) {
                Swift.print("could not find key \(key) in JSON: \(context.debugDescription)")
            } catch let DecodingError.valueNotFound(type, context) {
                Swift.print("could not find type \(type) in JSON: \(context.debugDescription)")
            } catch let DecodingError.typeMismatch(type, context) {
                Swift.print("type mismatch for type \(type) in JSON: \(context.debugDescription)")
            } catch let DecodingError.dataCorrupted(context) {
                Swift.print("data found to be corrupted in JSON: \(context.debugDescription)")
            } catch let error as NSError {
                NSLog("Error in read(from:ofType:) domain= \(error.domain), description= \(error.localizedDescription)")
            }
        }
        dataTask.resume()
    }

    // MARK: Private

    private let base_url = "http://public.codesquad.kr/jk/kakao-2021/"
}
