//
//  JSONDecoder.swift
//  StoreApp
//
//  Created by 지현우 on 2021/02/02.
//

import Foundation

class Decoder {
    static func parseToItem(data: Data) -> [Item] {
        var items: [Item] = []
        do {
            let str = String(data: data, encoding: .utf8)
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .deferredToDate
            decoder.keyDecodingStrategy = .useDefaultKeys
            items = try decoder.decode([Item].self, from: (str?.data(using: .unicode))!)
        } catch let DecodingError.keyNotFound(key, context) {
            Swift.print("could not find key \(key) in JSON: \(context.debugDescription)")
        } catch let DecodingError.valueNotFound(type, context) {
            Swift.print("could not find type \(type) in JSON: \(context.debugDescription)")
        } catch let DecodingError.typeMismatch(type, context) {
            Swift.print("type mismatch for type \(type) in JSON: \(context.debugDescription)")
        } catch let DecodingError.dataCorrupted(context) {
            Swift.print("data found to be corrupted in JSON: \(context.debugDescription)")
        } catch let error as NSError {
            NSLog("Error in read(from:ofType:) domain= \(error.domain), description= \(error.localizedDescription)")
        }
        return items
    }
    
    static func parseToDetail(data: Data) -> Detail? {
        var detail: Detail?
        do {
            let data1 = Data(String(data: data, encoding: .utf8)!.replacingOccurrences(of: "\\u", with: "").utf8)
            detail = try JSONDecoder().decode(Detail.self, from: data1)
            return detail
        } catch let DecodingError.keyNotFound(key, context) {
            Swift.print("could not find key \(key) in JSON: \(context.debugDescription)")
        } catch let DecodingError.valueNotFound(type, context) {
            Swift.print("could not find type \(type) in JSON: \(context.debugDescription)")
        } catch let DecodingError.typeMismatch(type, context) {
            Swift.print("type mismatch for type \(type) in JSON: \(context.debugDescription)")
        } catch let DecodingError.dataCorrupted(context) {
            Swift.print("data found to be corrupted in JSON: \(context.debugDescription)")
        } catch let error as NSError {
            NSLog("Error in read(from:ofType:) domain= \(error.domain), description= \(error.localizedDescription)")
        }
        return detail
    }
}
