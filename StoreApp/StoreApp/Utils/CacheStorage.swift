//
//  CacheStorage.swift
//  StoreApp
//
//  Created by 이준형 on 2021/02/02.
//  Copyright © 2021 이준형. All rights reserved.
//

import Foundation

class CacheStorage {
    let cacheUrl = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!

    func retrieve(_ fileName: String) -> Data? {
        guard FileManager.default.fileExists(atPath: cacheUrl.path) else { return nil }
        let fileUrl = cacheUrl.appendingPathComponent(fileName)
        return FileManager.default.contents(atPath: fileUrl.path)
    }

    func save(_ fileName: String, _ data: Data?) throws {
        let fileUrl = cacheUrl.appendingPathComponent(fileName)
        if FileManager.default.fileExists(atPath: fileUrl.path) {
            try FileManager.default.removeItem(at: fileUrl)
        }
        FileManager.default.createFile(atPath: fileUrl.path, contents: data, attributes: nil)
    }
}
