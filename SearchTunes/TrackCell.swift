//
//  TrackCell.swift
//  SearchTunes
//
//  Created by Antonio  Hernandez  on 4/5/17.
//  Copyright © 2017 Antonio  Hernandez . All rights reserved.
//

import UIKit

class TrackCell: UITableViewCell {

    @IBOutlet weak var songLabel: UILabel!
    
    @IBOutlet weak var artistLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        songLabel.sizeToFit()
        artistLabel.sizeToFit()
    }

    
    func configureCell(WithTrack track: Track) {
        self.songLabel.text = track.name
        self.artistLabel.text = track.artist
    }


}
