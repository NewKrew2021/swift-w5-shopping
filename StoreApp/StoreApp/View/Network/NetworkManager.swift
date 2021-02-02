//
//  NetworkManager.swift
//  StoreApp
//
//  Created by herb.salt on 2021/02/02.
//  Copyright © 2021 com.kakaocorp. All rights reserved.
//

import Foundation

class NetworkManager {
    
    func getItemData(category: String) {
        
        let url = "https://public.codesquad.kr/jk/kakao-2021/\(category).json"
        URLSession(configuration: URLSessionConfiguration.default).dataTask(with: URL(string: url)!) {
            (data, response, error) in
            guard let json = data else { return }
            let decoder = JSONDecoder()
            DispatchQueue.main.async {
                do {
                    let results = try decoder.decode([StoreItem].self, from: json)
                    NotificationCenter.default.post(name: Notification.Name(rawValue: "getItemData"), object: JsonData(category, results), userInfo: nil)
                } catch {
                    print(error.localizedDescription)
                }
            }
        }.resume()
        
    }
    
}
