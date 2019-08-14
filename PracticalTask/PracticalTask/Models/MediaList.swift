//
//  MediaList.swift
//  PracticalTask
//
//  Created by Hitesh Mistri on 8/14/19.
//  Copyright © 2019 Taykun. All rights reserved.
//

import Foundation
import ObjectMapper

class MediaList : Mappable {
    var wrapperType : String = ""
    var kind : String = ""
    var artistId : Int = -1
    var collectionId : Int = -1
    var trackId : Int = -1
    var artistName : String = ""
    var collectionName : String = ""
    var trackName : String = ""
    var collectionCensoredName : String = ""
    var trackCensoredName : String = ""
    var artistViewUrl : String = ""
    var collectionViewUrl : String = ""
    var trackViewUrl : String = ""
    var previewUrl : String = ""
    var artworkUrl30 : String = ""
    var artworkUrl60 : String = ""
    var artworkUrl100 : String = ""
    var collectionPrice : Double = 0.0
    var trackPrice : Double = 0.0
    var releaseDate : String = ""
    var collectionExplicitness : String = ""
    var trackExplicitness : String = ""
    var discCount : Int = 0
    var discNumber : Int = 0
    var trackCount : Int = 0
    var trackNumber : Int = 0
    var trackTimeMillis : Int = 0
    var country : String = ""
    var currency : String = ""
    var primaryGenreName : String = ""
    var isStreamable : Bool = false
    var longDescription:String = ""
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        wrapperType <- map["wrapperType"]
        kind <- map["kind"]
        artistId <- map["artistId"]
        collectionId <- map["collectionId"]
        trackId <- map["trackId"]
        artistName <- map["artistName"]
        collectionName <- map["collectionName"]
        trackName <- map["trackName"]
        collectionCensoredName <- map["collectionCensoredName"]
        trackCensoredName <- map["trackCensoredName"]
        artistViewUrl <- map["artistViewUrl"]
        collectionViewUrl <- map["collectionViewUrl"]
        trackViewUrl <- map["trackViewUrl"]
        previewUrl <- map["previewUrl"]
        artworkUrl30 <- map["artworkUrl30"]
        artworkUrl60 <- map["artworkUrl60"]
        artworkUrl100 <- map["artworkUrl100"]
        collectionPrice <- map["collectionPrice"]
        trackPrice <- map["trackPrice"]
        releaseDate <- map["releaseDate"]
        collectionExplicitness <- map["collectionExplicitness"]
        trackExplicitness <- map["trackExplicitness"]
        discCount <- map["discCount"]
        discNumber <- map["discNumber"]
        trackCount <- map["trackCount"]
        trackNumber <- map["trackNumber"]
        trackTimeMillis <- map["trackTimeMillis"]
        country <- map["country"]
        currency <- map["currency"]
        primaryGenreName <- map["primaryGenreName"]
        isStreamable <- map["isStreamable"]
        longDescription <- map["longDescription"]
    }
    
}

class AllMediaList: Mappable {
    var list : [MediaList] = []
//    var products = List<MediaList>()
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
//        list <- map ["results"]
//        list <- (map["results"], ArrayTransform<MediaList>())
        
    }
    
}
