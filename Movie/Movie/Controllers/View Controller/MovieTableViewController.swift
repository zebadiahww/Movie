//
//  MovieTableViewController.swift
//  Movie
//
//  Created by Zebadiah Watson on 10/4/19.
//  Copyright © 2019 Zebadiah Watson. All rights reserved.
//

import UIKit

class MovieTableViewController: UITableViewController, UISearchBarDelegate {
    //Outlets
    @IBOutlet weak var movieSearchBar: UISearchBar!
    
    var movieSearchResult: [Results] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        movieSearchBar.delegate = self
        self.tableView.estimatedRowHeight = 200
        self.tableView.rowHeight = 200
        

    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text, !searchText.isEmpty else { return }
        MovieController.fetchMovie(searchText: searchText) { (results) in
            self.movieSearchResult = results
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return movieSearchResult.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as! MovieInfoTableViewCell

        let searchResult = movieSearchResult[indexPath.row]
        cell.movieItem = searchResult
        return cell
    }
    

} // End of Class
