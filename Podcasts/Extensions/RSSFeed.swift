//
//  RSSFeed.swift
//  Podcasts
//
//  Created by Rish on 10/10/18.
//  Copyright © 2018 Rishabh Raj. All rights reserved.
//

import FeedKit

extension RSSFeed {
    func toEpisode() -> [Episode] {
        let imageUrl = iTunes?.iTunesImage?.attributes?.href
        
        var episodes = [Episode]()
        items?.forEach({ (feedItem) in
            var episode = Episode(feedItem: feedItem)
            if episode.imageURL == nil {
                episode.imageURL = imageUrl
            }
            episodes.append(episode)
        })
        return episodes
    }
}
