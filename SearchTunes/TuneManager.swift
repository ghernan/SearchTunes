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
    
 
    func persistTunes(withFilter filter: String = "", completionHandler: @escaping (_ tracks: [Track]) -> (), errorHandler: @escaping (_ error: Error) -> ()) {
        
        service.getTuneResults(withFilter: filter,
                               completionHandler: { (dict) in
                                    completionHandler(self.getParsedTracks(fromJSONDictionary: dict))
                                },
                               errorHandler:{ (error) in
                                    print("DataTask Error: \(error.localizedDescription)\n")
                                    errorHandler(error)
                                })
        
        
    }
    func getCachedTracks(withFilter filter: String = "")-> [Track]{
        var tracks : [Track] = [
            Track("Angel Eyes", artist: "ABBA", previewURL: URL(string:"http://a1896.phobos.apple.com/us/r30/Music/c3/15/ef/mzm.blsxeimy.aac.p.m4a")!),
            Track("Chiquitita", artist: "ABBA", previewURL: URL(string:"http://a1988.phobos.apple.com/us/r30/Music/e4/fe/20/mzm.rtvizizr.aac.p.m4a")!),
            Track("Summer Night City", artist: "ABBA", previewURL: URL(string:"http://a663.phobos.apple.com/us/r30/Music/51/c3/4b/mzm.uzosmanl.aac.p.m4a")!)
        ]
        
        if !filter.isEmpty{
            tracks = tracks.filter { track in
                return (track.name.lowercased().contains(filter.lowercased()))
            }
        }
        
        return tracks
    
    }
    private func getParsedTracks(fromJSONDictionary dict: JSONDictionary) -> [Track]{
        var tracks : [Track] = []
       
        //: Check the `results` value is an array:
        guard let array = dict["results"] as? [Any] else {
            print("Dictionary does not contain results key\n")
            return tracks
        }
        //Iterate over the array, extracting values to create a new Track object:
        for trackDictionary in array {
            if let trackDictionary = trackDictionary as? JSONDictionary {
                let newTrack = Track(with: trackDictionary)
                if !(tracks.contains(where: { (track) -> Bool in
                    if newTrack != track{
                        return false
                    }
                    else{
                        return true
                    }
                })){
                    tracks.append(newTrack)
                
                }
                
            } else {
                print("Problem parsing trackDictionary\n")
            }
        }
        return(tracks)
        
    }


    


}
