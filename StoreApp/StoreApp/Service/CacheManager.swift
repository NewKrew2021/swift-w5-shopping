//
//  CacheManager.swift
//  StoreApp
//
//  Created by bean Milky on 2021/02/03.
//

import UIKit

protocol CacheManagable {
    var imageCache: NSCache <NSString, UIImage> { get }
    var fileManager: FileManager { get }
    func getImage(forKey: String) -> UIImage?
    func setImage(image: UIImage, forKey: String)
}

class CacheManager {
    private let imageCache = NSCache<NSString, UIImage>()
    let fileManager: FileManager = FileManager()

    func getImage(forKey: String) -> UIImage? {
        guard let image = imageCache.object(forKey: forKey as NSString) else {
            return nil
        }
        return image
    }

    func setImage(image: UIImage, forKey: String) {
        imageCache.setObject(image, forKey: forKey as NSString)
    }

    func getData(localUrl: URL, forKey: String) -> Data? {
        guard let path = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first else { return nil }
        var filePath = URL(fileURLWithPath: path)
        filePath.appendPathComponent(forKey)

        if !fileManager.fileExists(atPath: filePath.path) {
            do {
                try fileManager.copyItem(at: localUrl, to: filePath)
                return try? Data(contentsOf: localUrl)
            } catch {
                return nil
            }
        } else {
            return try? Data(contentsOf: localUrl)
        }

    }

}
