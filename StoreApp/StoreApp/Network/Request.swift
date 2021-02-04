//
//  Request.swift
//  StoreApp
//
//  Created by 지현우 on 2021/02/01.
//

import UIKit

// MARK: - Request

class Request {
    // MARK: Internal

    static let shared = Request()

    static let DidReceiveItemsNotification = Notification.Name("DidReceiveItems")
    static let DidReceiveImageNotification = Notification.Name("DidReceiveImage")
    static let DidReceiveDetailNotification = Notification.Name("DidReceiveDetail")

    func requestItem(type: String) {
        guard let url = URL(string: "\(base_itemUrl)\(type).json") else { return }

        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: url) { data, _, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }

            guard let data = data else { return }

            NotificationCenter.default.post(name: Self.DidReceiveItemsNotification, object: nil, userInfo: ["Items": Decoder.parseToItem(data: data)])
        }
        dataTask.resume()
    }

    func requestDetail(storeDomain: String, productId: Int, completionHandler: @escaping (Detail?, Error?) -> Void) {
        guard let url = URL(string: "\(base_detailUrl)\(storeDomain)/product/\(productId)/detail") else { return }

        let session = URLSession(configuration: .default)
        session.dataTask(with: url) { data, _, error in
            if let error = error {
                print(error.localizedDescription)
                completionHandler(nil, nil)
                return
            }

            guard let data = data, let detail = Decoder.parseToDetail(data: data) else { return }
            completionHandler(detail, nil)

//            NotificationCenter.default.post(name: Self.DidReceiveDetailNotification, object: nil, userInfo: ["Detail": detail])
        }.resume()
    }

    func loadImage(
        url: URL,
        completion: @escaping (UIImage?, Error?) -> Void
    ) {
        guard let query = url.query else {
            completion(nil, nil)
            return
        }
        // 캐싱할 디렉토리 설정
        guard let cacheDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else { return }
        let cachedFile = cacheDirectory.appendingPathComponent(query, isDirectory: false)

        // 이미지가 이미 캐시 디렉토리에 존재함
        if let image = UIImage(contentsOfFile: cachedFile.path) {
            // 캐시된 이미지 반환
            completion(image, nil)
            return
        }

        // 이미지가 캐시 디렉토리에 존재하지 않을 때, 다운로드
        download(url: url, toFile: cachedFile) { error in
            let image = UIImage(contentsOfFile: cachedFile.path)
            completion(image, error)
        }
    }

    // MARK: Private

    private let base_itemUrl = "http://public.codesquad.kr/jk/kakao-2021/"
    private let base_detailUrl = "https://store.kakao.com/a/"

    private func download(
        url: URL,
        toFile file: URL,
        completion: @escaping (Error?) -> Void
    ) {
        URLSession.shared.downloadTask(with: url) {
            tempURL, _, error in
            guard let tempURL = tempURL else {
                completion(error)
                return
            }

            do {
                // 캐싱할 디렉토리 경로가 존재하는지 확인
                if FileManager.default.fileExists(atPath: file.path) {
                    try FileManager.default.removeItem(at: file)
                }

                // 다운로드 받아온 파일을 캐시 디렉토리로 복사
                try FileManager.default.copyItem(
                    at: tempURL,
                    to: file
                )

                completion(nil)
            } catch {
                completion(error)
            }
        }.resume()
    }
}
