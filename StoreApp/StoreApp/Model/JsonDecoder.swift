//
//  JsonDecoder.swift
//  StoreApp
//
//  Created by 윤준수 on 2021/02/01.
//

import Foundation

class JsonDecoder {
    func parseData(data: Data) -> [Product] {
        let decoder = JSONDecoder()
        var decodeData: [Product] = []
        do {
            decodeData = try decoder.decode([Product].self, from: data)
        }catch {
            print(error.localizedDescription)
        }
        return decodeData
    }
}
