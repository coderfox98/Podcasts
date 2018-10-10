//
//  EpisodeCell.swift
//  Podcasts
//
//  Created by Rish on 02/10/18.
//  Copyright © 2018 Rishabh Raj. All rights reserved.
//

import UIKit

class EpisodeCell: UITableViewCell {
    
    var episode : Episode! {
        didSet {
            descriptionLabel.text = episode.description
            titleLabel.text = episode.title
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM dd, yyyy"
            pubDateLabel.text = dateFormatter.string(from: episode.pubDate)
        }
    }

    @IBOutlet weak var episodeImageView: UIImageView!
    @IBOutlet weak var pubDateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!{
        didSet {
            descriptionLabel.numberOfLines = 2
        }
    }
    
}
