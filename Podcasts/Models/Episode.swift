//
//  Episode.swift
//  Podcasts
//
//  Created by Rish on 02/10/18.
//  Copyright © 2018 Rishabh Raj. All rights reserved.
//

import Foundation
import FeedKit

struct Episode {
    let title: String
    let pubDate : Date
    let description : String
    var imageURL : String?
    
    init(feedItem: RSSFeedItem) {
        self.title = feedItem.title ?? ""
        self.pubDate = feedItem.pubDate ?? Date()
        self.description = feedItem.description ?? ""
        self.imageURL = feedItem.iTunes?.iTunesImage?.attributes?.href ?? "" 
        
    }
}

