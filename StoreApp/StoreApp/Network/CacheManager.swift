//
//  CacheManager.swift
//  StoreApp
//
//  Created by 지현우 on 2021/02/03.
//

import Foundation

class CacheManager {
    static func hasFile(at path: String) -> Bool {
        print("hasFile")
        return FileManager.default.fileExists(atPath: path)
    }

    static func removeItem(url: URL) throws {
        print("removeItem")
        try FileManager.default.removeItem(at: url)
    }

    static func copyItem(from: URL, to: URL) throws {
        print("copyItem")
        print("from : \(from)")
        print("to : \(to)")
        try FileManager.default.copyItem(at: from, to: to)
    }
}
