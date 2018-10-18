//
//  AudioPostTableViewCell.swift
//  LambdaTimeline
//
//  Created by David Doswell on 10/16/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import UIKit

class AudioPostTableViewCell: UITableViewCell {

    var author: Author?
    
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var playButton: UIButton!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)

        setUpViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpViews() {
        authorLabel.text = author?.displayName
        playButton.setTitle(playButtonTitle, for: .normal)
    }
    
    private let playButtonTitle = "Play"
}
