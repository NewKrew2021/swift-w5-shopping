//
//  DownloadManager.swift
//  StoreApp
//
//  Created by herb.salt on 2021/02/04.
//  Copyright © 2021 com.kakaocorp. All rights reserved.
//

import Foundation

class DownloadManager {
        
    enum Result {
        case success(Data)
        case failure
    }
    
    static func downloadWithDataTask(from urlString: String, completionHandler: @escaping (Result) -> Void) {
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
