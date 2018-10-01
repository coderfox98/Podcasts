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

        let url = "https://itunes.apple.com/search"
        let parameters = ["term": searchText, "media": "podcast"]
        
        Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseData { (dataResponse) in
            if let error = dataResponse.error {
                print(error)
                return
            }
            guard let data = dataResponse.data else { return }
            
            do {
                let searchResult = try JSONDecoder().decode(SearchResult.self, from: data)
                print("The search Result:-",searchResult.resultCount)
                searchResult.results .forEach({ (podcast) in
                    print(podcast.artistName ?? "", podcast.trackName ?? "")
                })
                self.podcasts = searchResult.results
                self.tableView.reloadData()
                
            } catch let decodeError {
                print("Error in decoding:-", decodeError)
            }
        }
        
    }
    
    struct SearchResult : Decodable {
        let resultCount : Int
        let results : [Podcast]
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
