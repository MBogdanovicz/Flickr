//
//  Photo.swift
//  Flickr
//
//  Created by Marcelo Bogdanovicz on 22/07/19.
//  Copyright © 2019 Flickr. All rights reserved.
//

import Foundation
import ObjectMapper

class PhotoRequest: Mappable {
 
    class Photo: Mappable {
        
        var id: String?
        var owner: String?
        var secret: String?
        var server: String?
        var farm: Int?
        var title: String?
        var ispublic: Bool?
        var isfriend: Bool?
        var isfamily: Bool?
        
        required init?(map: Map) {
        }
        
        func mapping(map: Map) {
            id <- map["id"]
            owner <- map["owner"]
            secret <- map["secret"]
            server <- map["server"]
            farm <- map["farm"]
            title <- map["title"]
            ispublic <- map["ispublic"]
            isfriend <- map["isfriend"]
            isfamily <- map["isfamily"]
        }
    }
    
    var page: Int?
    var pages: Int?
    var perpage: Int?
    var total: String?
    var photo: [Photo]?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        page <- map["photos.page"]
        pages <- map["photos.pages"]
        perpage <- map["photos.perpage"]
        total <- map["photos.total"]
        photo <- map["photos.photo"]
    }
}

class PhotoInfo: Mappable {
    
    var id: String?
    var secret: String?
    var server: String?
    var farm: Int?
    var dateuploaded: Date?
    var owner: User?
    var title: String?
    var views: String?
    var description: String?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        id <- map["photo.id"]
        secret <- map["photo.secret"]
        server <- map["photo.server"]
        farm <- map["photo.farm"]
        dateuploaded <- (map["photo.dateuploaded"], DateTransform())
        owner <- map["photo.owner"]
        title <- map["photo.title._content"]
        views <- map["photo.views"]
        description <- map["photo.description._content"]
    }
}

class PhotoSizeRequest: Mappable {

    var size: [PhotoSize]?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        size <- map["sizes.size"]
    }
}

class PhotoSize: Mappable {
    
    var label: String?
    var width: Int?
    var height: Int?
    var source: String?
    var url: String?
    var media: String?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        label <- map["label"]
        width <- map["width"]
        height <- map["height"]
        source <- map["source"]
        url <- map["url"]
        media <- map["media"]
    }
}
