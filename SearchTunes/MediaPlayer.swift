//
//  MediaPlayer.swift
//  SearchTunes
//
//  Created by Antonio  Hernandez  on 4/24/17.
//  Copyright © 2017 Antonio  Hernandez . All rights reserved.
//

import Foundation
import AVFoundation

private var player: AVPlayer!
class MediaPlayer{
    
    func configurePlayer(withURL url: URL){
        do{
            let playerItem =  AVPlayerItem(url:url)
            player = AVPlayer(playerItem:playerItem)
            player.volume = 1.0
            player.play()
            
        }
        
    }



}
