//
//  TuneDetailsController.swift
//  SearchTunes
//
//  Created by Antonio  Hernandez  on 4/21/17.
//  Copyright © 2017 Antonio  Hernandez . All rights reserved.
//

import UIKit


class TuneDetailsController: UIViewController {
    var detailManager: TuneManager = TuneManager()
    var track: Track!
    var player: MediaPlayer = MediaPlayer()
    
    @IBOutlet weak var artistLabel: UILabel!
    
    @IBOutlet weak var tuneLabel: UILabel!
    @IBOutlet weak var tuneImage: UIImageView!

    @IBAction func playMedia(_ sender: UIButton) {
        playTune()
        
    }
    
    @IBAction func toItunes(_ sender: UIButton) {
        detailManager.openLink(withURL: track.trackViewURL)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTrackImage()
    }
    
    
    func configureLabels(){
        tuneLabel.text = track.name
        artistLabel.text = track.artist
        
    }
    func setTrackImage(){
        detailManager.downloadImage(withURL: track.artworkURL,
                                    completionHandler: { (img) in
                                        DispatchQueue.main.async {
                                            self.tuneImage.image = img
                                            self.configureLabels()
                    
                                        }
                                    },
                                    errorHandler: {error in
                                        print(error)
                                    })
    }
    func playTune(){
        detailManager.downloadTrack(fromURL: track.previewURL,
                                   completionHandler: { (tuneWithURL) in
                                        self.player.configurePlayer(withURL: tuneWithURL)
          
                                    },
                                    errorHandler: {error in
                                        print(error)
                                    })
    }
}
