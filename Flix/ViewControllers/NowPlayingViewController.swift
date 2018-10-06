//
//  NowPlayingViewController.swift
//  Flix
//
//  Created by Andre Campbell on 9/1/18.
//  Copyright © 2018 Andre Campbell. All rights reserved.
//

import UIKit
import AlamofireImage
import PKHUD

class NowPlayingViewController: UIViewController, UITableViewDataSource, UISearchBarDelegate {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    var movies: [Movie] = []
    var filteredMovies: [Movie] = []
    var refreshControl: UIRefreshControl!
    let alertController = UIAlertController(title: "Cannot Get Movies", message: "The internet connection appeas to be offline.", preferredStyle: .alert)
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector (NowPlayingViewController.didPullToRefresh(_:)), for: .valueChanged)
        tableView.insertSubview(refreshControl, at: 0)
        tableView.dataSource = self
        searchBar.delegate = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 50
        fetchMovies()
        // create a cancel action
        let retryAction = UIAlertAction(title: "retry", style: .default) { (action) in
            self.didPullToRefresh(self.refreshControl)
        }
        // add the cancel action to the alertController
        alertController.addAction(retryAction)

        
        
        
    }
    
    func didPullToRefresh(_ refreshControl: UIRefreshControl) {
        HUD.flash(.progress, delay: 1.0)
        fetchMovies()
       
    }
    func fetchMovies() {
        MovieApiManager().nowPlayingMovies { (movies: [Movie]?, error: Error?) in
            if let movies = movies {
                self.movies = movies
                self.filteredMovies = movies
                self.tableView.reloadData()
                self.refreshControl.endRefreshing()
            }
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredMovies.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for:indexPath) as! MovieCell
        cell.movie = filteredMovies[indexPath.row]
//        let title = movie.title
//        let overview = movie.overview
//        cell.titleLabel.text = title
//        cell.overviewLabel.text = overview
//        let posterUrl = movie.posterUrl!
//        cell.posterImageView.af_setImage(withURL: posterUrl)
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! UITableViewCell
        if let indexPath = tableView.indexPath(for: cell) {
            let movie = movies[indexPath.row]
            let detailViewController = segue.destination as! DetailViewController
            detailViewController.movie = movie
        }
        
    }
    // This method updates filteredData based on the text in the Search Box
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // When there is no text, filteredData is the same as the original data
        // When user has entered text into the search box
        // Use the filter method to iterate over all items in the data array
        // For each item, return true if the item should be included and false if the
        // item should NOT be included
        filteredMovies = searchText.isEmpty ? movies : movies.filter { (item: Movie) -> Bool in
            // If dataItem matches the searchText, return true to include it
            let title = item.title
            return title.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        }
        
        tableView.reloadData()
    }
   }
