//
//  TuneManager.swift
//  SearchTunes
//
//  Created by Antonio  Hernandez  on 4/5/17.
//  Copyright © 2017 Antonio  Hernandez . All rights reserved.
//

import Foundation
import UIKit
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
            
            Track("Angel Eyes", artist: "ABBA", previewURL: URL(string:"http://a1988.phobos.apple.com/us/r30/Music/e4/fe/20/mzm.rtvizizr.aac.p.m4a")!, trackViewURL: URL(string:"https://itunes.apple.com/us/album/angel-eyes/id510714434?i=510714438&uo=4")!, artworkURL: URL(string:"http://is1.mzstatic.com/image/thumb/Music/v4/09/a2/76/09a2765c-8c2a-9dee-6774-4a95a7f1e437/source/100x100bb.jpg")!),
            
            Track("Chiquitita", artist: "ABBA", previewURL: URL(string:"http://a888.phobos.apple.com/us/r30/Music4/v4/2f/40/12/2f40126a-c664-540d-ca86-cc6ee622072e/mzaf_2428154513987494316.plus.aac.p.m4a")!, trackViewURL: URL(string:"https://itunes.apple.com/us/album/chiquitita/id850009855?i=850009876&uo=4")!, artworkURL: URL(string:"http://is1.mzstatic.com/image/thumb/Music4/v4/95/20/8f/95208fc6-629f-6ac9-c8db-69357b9b69d2/source/100x100bb.jpg")!),
            
            Track("Summer Night City", artist: "ABBA", previewURL: URL(string:"http://a663.phobos.apple.com/us/r30/Music/51/c3/4b/mzm.uzosmanl.aac.p.m4a")!, trackViewURL: URL(string:"https://itunes.apple.com/us/album/summer-night-city/id510714434?i=510714437&uo=4")!, artworkURL: URL(string:"http://is1.mzstatic.com/image/thumb/Music/v4/09/a2/76/09a2765c-8c2a-9dee-6774-4a95a7f1e437/source/100x100bb.jpg")!)
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
        guard let results = dict["results"] as? [Any] else {
            print("Dictionary does not contain results key\n")
            return tracks
        }
        //Iterate over the array, extracting values to create a new Track object:
        for trackDictionary in results {
            guard let trackDictionary = trackDictionary as? JSONDictionary else {
                print("Could not parse JSON object")
                continue
            }
            let newTrack = Track(with: trackDictionary)
            if !(tracks.contains{ newTrack == $0}){
                    tracks.append(newTrack)
            }          
        }
        return(tracks)
        
    }
    
    func downloadImage(withURL url: URL, completionHandler: @escaping(_ image:UIImage)->(), errorHandler:@escaping(_ error:Error)->()){
        service.getImageData(fromUrl: url,
                                    completionHandler: { (imgData) in
                                        completionHandler(UIImage(data:imgData)!)
                                        
        },
                                    errorHandler: {error in
                                        errorHandler(error)
        })
        
    }
    func downloadTrack(fromURL url: URL, completionHandler: @escaping(_ url:URL)->(), errorHandler:@escaping(_ error:Error)->()){
        service.getTuneURL(fromURL: url,
                                  completionHandler: { (ulr) in
                                    completionHandler(url)
                                    
        },
                                  errorHandler: {error in
                                    errorHandler(error)
        })
    }
    func openLink(withURL url: URL){
        UIApplication.shared.open(url, options: [:]) { (opened) in
            print("URL did open: \(opened)")
        }
    }



    


}
