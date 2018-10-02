//
//  PodcastSearchController.swift
//  Podacasts
//
//  Created by Rish on 01/10/18.
//  Copyright © 2018 Rishabh Raj. All rights reserved.
//

import UIKit
import Alamofire

class PodcastsSearchController: UITableViewController, UISearchBarDelegate {
    
    var podcasts = [
        Podcast(trackName:"coderfox98", artistName: "Rish Studio"),
        Podcast(trackName:"coderfox98", artistName: "Rish Studio")
    ]
    
    let cellId = "cellId"
    
    //MARK:- Search Controller
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSearchBar()
        setupTableView()
        
    }
    
    //MARK:- SetupSearchBar
    
    fileprivate func setupSearchBar() {
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        APIService.shared.fetchPodcast(searchText: searchText) { (podcasts) in
            self.podcasts = podcasts
            self.tableView.reloadData()
        }
    }
    
    
    //MARK:- UITableView
    
    fileprivate func setupTableView() {
        // Register Call for the TableView
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return podcasts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        let podcast = podcasts[indexPath.item]
        cell.textLabel?.numberOfLines = -1
        cell.textLabel?.text = "\(podcast.trackName ?? "")\n\(podcast.artistName ?? "")"
        cell.imageView?.image = UIImage(named: "podcast")
        cell.imageView?.contentMode = .scaleAspectFit
        return cell
    }
    
}
