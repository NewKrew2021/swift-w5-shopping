//
//  Network.swift
//  TVApp
//
//  Created by bean Milky on 2021/01/26.
//

import Foundation

protocol NetworkManable {
    func getResource(from: String, completion: @escaping (Data?, Error?) -> Void) throws
    func getResource(endPoint: EndPoint?, from: String, method: RequestMethod, payload: Data?, completion: @escaping (Data?, Error?) -> Void) throws
    func download(from: String, completion: @escaping (Data?, Error?) -> Void) throws
}

extension NetworkManable {
    func getResource(endPoint: EndPoint?, from: String, method: RequestMethod = RequestMethod.GET, payload: Data? = nil, completion: @escaping (Data?, Error?) -> Void) throws {
        try getResource(endPoint: endPoint, from: from, method: method, payload: payload, completion: completion)
    }

}

enum RequestMethod: String {
    case GET, POST, PUT, DELETE
}

enum NetworkErrorCase: Error {
    case invalidURL
    case serverError
    case cacheError
}

enum EndPoint: String {
    case baseUrl =  "https://public.codesquad.kr/jk/kakao-2021"
    static let paymentUrl = "https://hooks.slack.com/services/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"
}

class NetworkManager: NetworkManable {
    typealias EndPointType = EndPoint
    let cacheManager = CacheManager()

    func getResource(from: String, completion: @escaping (Data?, Error?) -> Void) throws {
        try self.getResource(endPoint: nil, from: from, completion: completion)
    }

    func getResource(endPoint: EndPoint?, from: String, method: RequestMethod = .GET, payload: Data? = nil, completion: @escaping (Data?, Error?) -> Void) throws {
        var _from: String = from
        if let endPoint = endPoint { _from = endPoint.rawValue + _from }
        guard let url = URL(string: _from) else { throw NetworkErrorCase.invalidURL }
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = method.rawValue
        request.httpBody = payload
        print(payload)
        URLSession.shared.dataTask(with: request) {
            (data, response, error) in
            guard let data = data, error == nil else {
                completion(nil, error)
                return
            }
            print(data)
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                completion(nil, NetworkErrorCase.serverError)
                return
            }
            DispatchQueue.main.async {
                completion(data, nil)
            }
        }.resume()
    }

    func download(from: String, completion: @escaping (Data?, Error?) -> Void) throws {
        guard let remoteUrl = URL(string: from) else {
            throw NetworkErrorCase.invalidURL
        }
        var request = URLRequest(url: remoteUrl)
        request.httpMethod = RequestMethod.GET.rawValue
        URLSession.shared.downloadTask(with: request) {
            (url, response, error) in
            guard let localUrl = url, error == nil else {
                completion(nil, error)
                return
            }
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                completion(nil, NetworkErrorCase.serverError)
                return
            }

            if let data = self.cacheManager.getData(localUrl: localUrl, forKey: remoteUrl.query ?? remoteUrl.lastPathComponent) {
                completion(data, nil)
            } else {
                completion(nil, NetworkErrorCase.cacheError)
            }
        }.resume()
    }

}
