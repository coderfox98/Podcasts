//
//  EpisodesController.swift
//  Podcasts
//
//  Created by Rish on 02/10/18.
//  Copyright © 2018 Rishabh Raj. All rights reserved.
//

import UIKit
import FeedKit

class EpisodesController : UITableViewController {
    
    fileprivate let cellId = "cellId"
    
    
    var episodes = [Episode]()
    
    var podcast : Podcast? {
        didSet {
            navigationItem.title = podcast?.trackName
            fetchEpisodes()
        }
    }
    
    fileprivate func fetchEpisodes(){
        
        guard let feedUrl = podcast?.feedUrl else { return }
        let secureFeedUrl = feedUrl.contains("https") ? feedUrl : feedUrl.replacingOccurrences(of: "http", with: "https")
        
        guard let url = URL(string: secureFeedUrl) else { return }
        let parser = FeedParser(URL: url)
        parser.parseAsync { (result) in
            print("Sucess parsed feed", result.isSuccess)
            
            switch result{
            case let .rss(feed):
                 var episodes = [Episode]()
                feed.items?.forEach({ (feedItem) in
                    let episode = Episode(feedItem: feedItem)
                    episodes.append(episode)
                })
                  self.episodes = episodes
                 DispatchQueue.main.async {
                    self.tableView.reloadData()
                 }
                break
            case let .failure(error):
                print("Failed to parse feed", error)
                break
            default:
                print("Found another feed")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    //MARK:- SetupWork
    
    fileprivate func setupTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        tableView.tableFooterView = UIView()
    }
    
    //MARK:- UITableView
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return episodes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        let episode = episodes[indexPath.row]
        cell.textLabel?.text = episode.title
        return cell
    }
    
    
}
