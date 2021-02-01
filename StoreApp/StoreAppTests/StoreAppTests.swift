//
//  StoreAppTests.swift
//  StoreAppTests
//
//  Created by 윤준수 on 2021/02/01.
//

import XCTest

class StoreAppTests: XCTestCase {

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func testExample() throws {
        var net = networkTest()
//        net.test(url: "www.naver.com")
        net.test(url: "http://apple.com")
    }
}
