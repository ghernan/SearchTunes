//
//  Track.swift
//  URLSessionTutorial
//
//  Created by Antonio  Hernandez  on 3/31/17.
//  Copyright © 2017 Antonio  Hernandez . All rights reserved.
//

import Foundation

struct Track{
    var name: String
    var artist: String
    var previewURL: URL
    var trackViewURL: URL
    var artworkURL: URL
    
    
    init(_ name: String, artist: String, previewURL: URL,
         trackViewURL: URL, artworkURL: URL){
        self.name = name
        self.artist = artist
        self.previewURL = previewURL
        self.trackViewURL = trackViewURL
        self.artworkURL = artworkURL
        
    }
    init (with dict: JSONDictionary){
        name = dict["trackName"] as! String
        artist = dict["artistName"] as! String
        previewURL = URL(string:dict["previewUrl"] as! String)!
        trackViewURL = URL(string:dict["trackViewUrl"] as! String)!
        artworkURL = URL(string:dict["artworkUrl100"] as! String)!
    }
    
    
}

extension Track : Equatable{
    
    public static func ==(t1: Track, t2: Track) -> Bool{
        return t1.name == t2.name && t1.artist == t2.artist
    }

}


