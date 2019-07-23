//
//  User.swift
//  Flickr
//
//  Created by Marcelo Bogdanovicz on 22/07/19.
//  Copyright © 2019 Flickr. All rights reserved.
//

import Foundation
import ObjectMapper

class User: Mappable {

    var id: String?
    var nsid: String?
    var username: String?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        id <- map["user.id"]
        nsid <- map["user.nsid"]
        username <- map["user.username._content"]
    }
}
