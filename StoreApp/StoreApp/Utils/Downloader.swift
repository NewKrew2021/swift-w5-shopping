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
        case failure
    }
    
    static func downloadWithDataTask(from urlString: String, completionHandler: @escaping AfterTask) {
        guard let url = URL(string: urlString) else { return }
            
        URLSession.shared.downloadTask(with: url) { localURL, urlResponse, error in
            if let localURL = localURL {
                if let data = try? Data(contentsOf: localURL) {
                    completionHandler(.success(data))
                }
            }
        }.resume()
    }
}

