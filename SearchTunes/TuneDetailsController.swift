//
//  TuneDetailsController.swift
//  SearchTunes
//
//  Created by Antonio  Hernandez  on 4/21/17.
//  Copyright © 2017 Antonio  Hernandez . All rights reserved.
//

import UIKit

class TuneDetailsController: UIViewController {
    var detailManager: TuneDetailsManager = TuneDetailsManager()
    var track: Track!
    
    @IBOutlet weak var tuneImage: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setTrackImage()
    }
    func setTrackImage(){
        detailManager.downloadImage(withURL: track.artworkURL,
                                    completionHandler: { (img) in
                                        DispatchQueue.main.async {
                                            self.tuneImage.image = img
                                        }
                                    },
                                    errorHandler: {error in
                                        print(error)
                                    })
    }


}
