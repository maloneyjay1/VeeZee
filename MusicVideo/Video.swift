//
//  MV.swift
//  MusicVideo
//
//  Created by Jay Maloney on 2/19/16.
//  Copyright © 2016 Jay Maloney. All rights reserved.
//

import Foundation

class Videos {
    
    //keys
    private let labelKey = "label"
    private let linkKey = "link"
    private let idKey = "id"
    private let mvNameKey = "im:name"
    private let mvImageURLKey = "im:image"
    private let mvArtistKey = "im:artist"
    private let mvAttributesKey = "attributes"
    private let mvHrefKey = "href"
    private let mvCategoryKey = "category"
    private let mvReleaseDateKey = "im:releaseData"
    
    //encapsulators
    private var _mvName:String
    private var _mvRights:String
    private var _mvPrice:String
    private var _mvImageURL:String
    private var _mvArtist:String
    private var _mvVideoURL:String
    private var _mvImID:String
    private var _mvGenre:String
    private var _mvLinkToiTunes:String
    private var _mvReleaseDate:String
    
    //accessors
    var mvName:String {return _mvName}
    var mvRights:String {return _mvRights}
    var mvPrice:String {return _mvPrice}
    var mvImageURL:String {return _mvImageURL}
    var mvArtist:String {return _mvArtist}
    var mvVideoURL:String {return _mvVideoURL}
    var mvImID:String {return _mvImID}
    var mvGenre:String {return _mvGenre}
    var mvLinkToiTunes:String {return _mvLinkToiTunes}
    var mvReleaseDate:String {return _mvReleaseDate}
    
    var vImageData:NSData?
    
    init(resultData:jsonDictionary) {
        //mvName
        if let name = resultData[mvNameKey] as? jsonDictionary,
            mvName = name[labelKey] as? String {
                self._mvName = mvName
        } else {
            self._mvName = "No name field found in JSON call."
        }
        
        //mvRights
        if let rights = resultData["rights"] as? jsonDictionary,
            mvRights = rights["label"] as? String {
                self._mvRights = mvRights
        } else {
            self._mvRights = "No rights field found in JSON call."
        }
        
        //mvPrice
        if let price = resultData["im:price"] as? jsonDictionary,
            mvPrice = price["label"] as? String {
                self._mvPrice = mvPrice
        } else {
            self._mvPrice = "No price field found in JSON call."
        }
        
        //mvImageURL
        if let image = resultData[mvImageURLKey] as? jsonDictionary,
            mvImageURL = image[labelKey] as? String {
                self._mvImageURL = mvImageURL.stringByReplacingOccurrencesOfString("100x100", withString: "600x600")
        } else {
            self._mvImageURL = "No image field found in JSON call."
        }
        
        
        //mvArtistw
        if let artist = resultData[mvArtistKey] as? jsonDictionary,
            mvArtist = artist[labelKey] as? String {
                self._mvArtist = mvArtist
        } else {
            self._mvArtist = "No artist field found in JSON call."
        }
        
        //mvVideoURL
        if let videoArray = resultData[linkKey] as? jsonArray,
            videoDict = videoArray[1] as? jsonDictionary,
            vHref = videoDict[mvAttributesKey] as? jsonDictionary,
            mvVideoURL = vHref[mvHrefKey] as? String {
                self._mvVideoURL = mvVideoURL
        } else {
            self._mvVideoURL = "No videoURL found in JSON call."
        }
        
        //mvImID
        if let id = resultData[idKey] as? jsonDictionary,
            mvImID = id[labelKey] as? String {
                self._mvImID = mvImID
        } else {
            self._mvImID = "No id found in JSON call."
        }
        
        //genre/category
        if let genre = resultData[mvCategoryKey] as? jsonDictionary,
        attributes = genre[mvAttributesKey] as? jsonDictionary,
            mvGenre = attributes[labelKey] as? String {
                self._mvGenre = mvGenre
        } else {
            self._mvGenre = "No genre found in JSON call."
        }
        
        //mvLink
        if let Array = resultData[linkKey] as? jsonArray,
            linkDict = Array[0] as? jsonDictionary,
            vHref = linkDict[mvAttributesKey] as? jsonDictionary,
            mvLinkToiTunes = vHref[mvHrefKey] as? String {
                self._mvLinkToiTunes = mvLinkToiTunes
        } else {
            self._mvLinkToiTunes = "No videoURL found in JSON call."
        }
        
        //mvReleaseDate
        if let releaseDate = resultData[mvReleaseDateKey] as? jsonDictionary,
        dateDict = releaseDate[mvAttributesKey] as? jsonDictionary,
            mvReleaseDate = dateDict[labelKey] as? String {
                self._mvReleaseDate = mvReleaseDate
        } else {
            self._mvReleaseDate = "No release data found in JSON call."
        }
    }
    
    
}
