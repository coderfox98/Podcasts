//
//  APIService.swift
//  Podcasts
//
//  Created by Rish on 02/10/18.
//  Copyright © 2018 Rishabh Raj. All rights reserved.
//

import Foundation
import Alamofire

class APIService {
    
    let baseItunesURL = "https://itunes.apple.com/search"
    
    //singleton
    static let shared = APIService()
    
    
    func fetchPodcast(searchText: String, completionHandler: @escaping ([Podcast]) -> ()) {
        
        let parameters = ["term": searchText, "media": "podcast"]
        
        Alamofire.request(baseItunesURL, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseData { (dataResponse) in
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
             completionHandler(searchResult.results)
//                self.podcasts = searchResult.results
//                self.tableView.reloadData()
                
            } catch let decodeError {
                print("Error in decoding:-", decodeError)
            }
        }
        
    }
    
    
    struct SearchResult : Decodable {
        let resultCount : Int
        let results : [Podcast]
    }
}
