//
//  StoreItems.swift
//  StoreApp
//
//  Created by 이준형 on 2021/02/01.
//  Copyright © 2021 이준형. All rights reserved.
//

import Foundation

enum JsonFileName : String {
    case best = "best"
    case mask = "mask"
    case grocery = "grocery"
    case fryingpan = "fryingpan"
    
    static let jsonFileName = [best, mask, grocery, fryingpan]
}

class StoreItems {
    var allItems : [[Item]] = [[]]
    
    var count : Int {
        return allItems.count
    }
    
    subscript(index : Int) -> [Item] {
        return allItems[index]
    }
    
    init() {
        for iter in JsonFileName.jsonFileName {
            guard let url = URL(string: "http://public.codesquad.kr/jk/kakao-2021/"+iter.rawValue+".json") else { return }
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                guard let data = data else { return }
                DispatchQueue.main.async {
                    do {
                        if let decodeData = try? JSONDecoder().decode([Item].self, from : data){
                            self.allItems.append(decodeData)
                        }
                    } catch {}
                }
            }.resume()
        }
    }
    
    private func decode(_ data : Data) -> [Item]? {
        do {
            return try JSONDecoder().decode([Item].self, from : data)
        } catch {
            return nil
        }
    }
}


