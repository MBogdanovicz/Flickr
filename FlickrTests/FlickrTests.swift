//
//  FlickrTests.swift
//  FlickrTests
//
//  Created by Marcelo Bogdanovicz on 19/07/19.
//  Copyright © 2019 Flickr. All rights reserved.
//

import XCTest
import ObjectMapper
@testable import Flickr

class FlickrTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }
    
    func fileURL(filename: String) -> URL? {
        let bundle = Bundle(for: type(of: self))
        return bundle.url(forResource: filename, withExtension: "json")
    }
    
    func testUserMapping() throws {
        guard let url = fileURL(filename: "User") else {
            XCTFail("Missing file: User.json")
            return
        }
        let json = try Data(contentsOf: url)
        let jsonString = String(data: json, encoding: .utf8)
        let user = User(JSONString: jsonString!)
        
        XCTAssertEqual(user?.username, "eyetwist")
        XCTAssertEqual(user?.nsid, "49191827@N00")
    }
    
    func testPhotosMapping() throws {
        guard let url = fileURL(filename: "Photos") else {
            XCTFail("Missing file: Photos.json")
            return
        }
        let json = try Data(contentsOf: url)
        let jsonString = String(data: json, encoding: .utf8)
        let photos = PhotoRequest(JSONString: jsonString!)
        
        XCTAssertEqual(photos?.page, 1)
        XCTAssertTrue(photos!.photo != nil)
        XCTAssertTrue(photos!.photo!.count > 0)
        XCTAssertEqual(photos!.photo![0].id, "48342263806")
    }
    
    func testPhotoInfoMapping() throws {
        guard let url = fileURL(filename: "Photo") else {
            XCTFail("Missing file: Photo.json")
            return
        }
        let json = try Data(contentsOf: url)
        let jsonString = String(data: json, encoding: .utf8)
        let photo = PhotoInfo(JSONString: jsonString!)
        
        XCTAssertEqual(photo?.id, "48342263806")
        XCTAssertEqual(photo?.secret, "04b37b8457")
        XCTAssertEqual(photo?.server, "65535")
        XCTAssertEqual(photo?.title, "alconquin video. los angeles, ca. 2009.")
    }
}
