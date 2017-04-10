//
//  TuneManager.swift
//  SearchTunes
//
//  Created by Antonio  Hernandez  on 4/5/17.
//  Copyright © 2017 Antonio  Hernandez . All rights reserved.
//

import Foundation

class TuneManager{
    let service = TuneService()
    typealias  JSONDictionary = [String:AnyObject]
 
    func persistTunes(withFilter filter: String = "", completionHandler: @escaping (_ tracks: [Track]) -> (), errorHandler: @escaping (_ error: Error) -> ()) {
        var tracks : [Track] = []
        tracks = cachedTracks(tracks: tracks)
        if !filter.isEmpty{
            tracks = tracks.filter { track in
                return (track.name.lowercased().contains(filter.lowercased()))
            }
        }
        service.getTuneResults(withFilter: filter,
                               completionHandler: { (dict) in
                                    completionHandler(self.parseJSON(with: dict as JSONDictionary, to: tracks))
                                },
                               errorHandler:{ (error) in
                                    print("DataTask Error: \(error.localizedDescription)\n")
                                    errorHandler(error)
                                })
        
        
    }
    private func parseJSON(with dict: JSONDictionary, to tracks: [Track]) -> [Track]{
        var tracks = tracks
        
        
       
        //: Check the `results` value is an array:
        guard let array = dict["results"] as? [Any] else {
            print("Dictionary does not contain results key\n")
            return tracks
        }
        //Iterate over the array, extracting values to create a new Track object:
        for trackDictionary in array {
            if let trackDictionary = trackDictionary as? JSONDictionary {
                tracks.append(Track(with: trackDictionary))
            } else {
                print("Problem parsing trackDictionary\n")
            }
        }
        
        
        
        print(tracks)
        return(tracks)
        
        
        
        
    
    }

    private func cachedTracks( tracks: [Track]) -> [Track]{
        var tracks = tracks
        tracks.append(Track("Angel Eyes", artist: "ABBA", previewURL: URL(string:"http://a1896.phobos.apple.com/us/r30/Music/c3/15/ef/mzm.blsxeimy.aac.p.m4a")!))
        tracks.append(Track("Chiquitita", artist: "ABBA", previewURL: URL(string:"http://a1988.phobos.apple.com/us/r30/Music/e4/fe/20/mzm.rtvizizr.aac.p.m4a")!))
        tracks.append(Track("Summer Night City", artist: "ABBA", previewURL: URL(string:"http://a663.phobos.apple.com/us/r30/Music/51/c3/4b/mzm.uzosmanl.aac.p.m4a")!))
        
        return tracks
        
    }
    


}
