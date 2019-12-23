//
//  NikeCodeTestTests.swift
//  NikeCodeTestTests
//
//  Created by KIRILL CHUMAK on 12/16/19.
//  Copyright © 2019 Kirill Chumak. All rights reserved.
//

import XCTest
@testable import NikeCodeTest

class NikeCodeTestTests: XCTestCase {
    
    var dataJSONFile: AlbumData?
    
    
    //MARK: NetworkReachabilityTests
    func testCallToiTunesCompletes() {
        let url =
            URL(string: "https://rss.itunes.apple.com/api/v1/us/apple-music/top-albums/all/100/explicit.json")
        let promise = expectation(description: "Completion handler invoked")
        var statusCode: Int?
        var responseError: Error?
        let dataTask = URLSession(configuration: .default).dataTask(with: url!) { data, response, error in
            statusCode = (response as? HTTPURLResponse)?.statusCode
            responseError = error
            promise.fulfill()
        }
        dataTask.resume()
        wait(for: [promise], timeout: 5)
        XCTAssertNil(responseError)
        XCTAssertEqual(statusCode, 200)
    }
    
    //MARK: JSONParsingTests
    func testJSONDataNumberOfItems() throws {
        let testBundle = Bundle(for: type(of: self))
        guard let path = testBundle.path(forResource: "test", ofType: "json") else {
            XCTFail("Missing file: test.json")
            return }
        let url = URL(fileURLWithPath: path)
        let data = try Data(contentsOf: url)
        self.dataJSONFile = try JSONDecoder().decode(AlbumData.self, from: data)
        XCTAssertEqual(dataJSONFile?.feed.results.count, 100)
    }
    
    
    func testJSONMapping() throws {
        let testBundle = Bundle(for: type(of: self))
        guard let path = testBundle.path(forResource: "test", ofType: "json") else {
            XCTFail("Missing file: test.json")
            return }
        let url = URL(fileURLWithPath: path)
        let data = try Data(contentsOf: url)
        self.dataJSONFile = try JSONDecoder().decode(AlbumData.self, from: data)
      
        XCTAssertEqual(dataJSONFile?.feed.results[0].artistName, "Young Thug")
        XCTAssertEqual(dataJSONFile?.feed.results[0].artworkUrl100, "https://is4-ssl.mzstatic.com/image/thumb/Music113/v4/7a/74/1a/7a741adc-211f-1203-f20d-af86f26caa1d/075679829153.jpg/200x200bb.png")
        XCTAssertEqual(dataJSONFile?.feed.results[0].copyright, "℗ 2019 300 Entertainment / Atlantic Recording Corporation")
        XCTAssertEqual(dataJSONFile?.feed.results[0].name, "So Much Fun (Deluxe)")
        XCTAssertEqual(dataJSONFile?.feed.results[0].releaseDate, "2019-08-16")
        XCTAssertEqual(dataJSONFile?.feed.results[0].url, "https://music.apple.com/us/album/so-much-fun-deluxe/1492389435?app=music")
        XCTAssertEqual(dataJSONFile?.feed.results[0].genres[0].name, "Hip-Hop/Rap")
    }
    
    
    
}
