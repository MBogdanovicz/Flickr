//
//  Services.swift
//  Flickr
//
//  Created by Marcelo Bogdanovicz on 21/07/19.
//  Copyright © 2019 Flickr. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

class Services {

    private static func makeRequest(endpoint: String, method: HTTPMethod = .get, parameters: [String: Any]) -> DataRequest {
        let commonParameters: [String: Any] = ["method": endpoint,
                      "api_key": "84e5361175d9e8c21ac2a7688f02a905",
                      "format": "json",
                      "nojsoncallback": "1"]
        
        let allParameters = commonParameters.merging(parameters) { (current, _) in current }
        return Alamofire.request("https://www.flickr.com/services/rest/", method: method, parameters: allParameters)
    }
    
    static func findByUsername(_ username: String, success: @escaping (String?) -> Void, fail: @escaping (Error?) -> Void) {
        
        let request = makeRequest(endpoint: "flickr.people.findByUsername", parameters: ["username": username])
        request.responseObject { (response: DataResponse<User>) in
            
            switch(response.result) {
            case .success(_):
                if let user = response.result.value {
                    success(user.id)
                } else {
                    success(nil)
                }
            case .failure(_):
                fail(response.result.error)
            }
        }
    }
    
    static func getPublicPhotos(userid: String, page: Int = 1, success: @escaping (PhotoRequest?) -> Void, fail: @escaping (Error?) -> Void) {
        
        let request = makeRequest(endpoint: "flickr.people.getPublicPhotos", parameters: ["user_id": userid, "page": page])
        request.responseObject { (response: DataResponse<PhotoRequest>) in
            
            switch(response.result) {
            case .success(_):
                if let photoRequest = response.result.value {
                    success(photoRequest)
                } else {
                    success(nil)
                }
            case .failure(_):
                fail(response.result.error)
            }
        }
    }
    
    static func getInfo(photoid: String, success: @escaping (PhotoInfo?) -> Void, fail: @escaping (Error?) -> Void) {
        
        let request = makeRequest(endpoint: "flickr.photos.getInfo", parameters: ["photo_id": photoid])
        request.responseObject { (response: DataResponse<PhotoInfo>) in
            
            switch(response.result) {
            case .success(_):
                if let photoInfo = response.result.value {
                    success(photoInfo)
                } else {
                    success(nil)
                }
            case .failure(_):
                fail(response.result.error)
            }
        }
    }
    
    static func getSizes(photoid: String, success: @escaping ([PhotoSize]?) -> Void, fail: @escaping (Error?) -> Void) {
        
        let request = makeRequest(endpoint: "flickr.photos.getSizes", parameters: ["photo_id": photoid])
        request.responseObject { (response: DataResponse<PhotoSizeRequest>) in
            
            switch(response.result) {
            case .success(_):
                if let photoSizeRequest = response.result.value {
                    success(photoSizeRequest.size)
                } else {
                    success(nil)
                }
            case .failure(_):
                fail(response.result.error)
            }
        }
    }
}
