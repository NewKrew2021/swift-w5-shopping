//
//  JsonDecoder.swift
//  StoreApp
//
//  Created by 윤준수 on 2021/02/01.
//

import Foundation

class JsonDecoder {
    func parseData(data: Data) -> [ProductJSON] {
        let decoder = JSONDecoder()
        var decodeData: [ProductJSON] = []
        do {
            decodeData = try decoder.decode([ProductJSON].self, from: data)
        }catch {
            print(error.localizedDescription)
        }
        return decodeData
    }
}
