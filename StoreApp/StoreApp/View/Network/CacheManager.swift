//
//  CacheManager.swift
//  StoreApp
//
//  Created by herb.salt on 2021/02/04.
//  Copyright © 2021 com.kakaocorp. All rights reserved.
//

import Foundation

class CacheManager {
    
    static let cacheUrl = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!

    static func retrieve(_ fileName: String) -> Data? {
        guard FileManager.default.fileExists(atPath: cacheUrl.path) else { return nil }
        let fileUrl = cacheUrl.appendingPathComponent(fileName)
        return FileManager.default.contents(atPath: fileUrl.path)
    }

    static func save(_ fileName: String, _ data: Data?) throws {
        let fileUrl = cacheUrl.appendingPathComponent(fileName)
        if FileManager.default.fileExists(atPath: fileUrl.path) {
            try FileManager.default.removeItem(at: fileUrl)
        }
        FileManager.default.createFile(atPath: fileUrl.path, contents: data, attributes: nil)
    }
    
}
