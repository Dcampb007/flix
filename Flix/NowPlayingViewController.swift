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
    var movies: [[String: Any]] = []
    var filteredMovies: [[String: Any]] = []
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
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
        // this will run when the network request returns
        if let error = error {
            self.present(self.alertController, animated: true) {
                // optional code for what happens after the alert controller has finished presenting
                print(error.localizedDescription)
            }
        }
        else if let data = data {
        let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
        let movies = dataDictionary["results"] as! [[String: Any]]
        self.movies = movies
        self.filteredMovies = self.movies
        self.tableView.reloadData()
        self.refreshControl.endRefreshing()
    
        }
        }
        task.resume()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredMovies.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for:indexPath) as! MovieCell
        let movie = filteredMovies[indexPath.row]
        let title = movie["title"] as! String
        let overview = movie["overview"] as! String
        cell.titleLabel.text = title
        cell.overviewLabel.text = overview
        let posterPathString = movie["poster_path"] as! String
        let posterUrl = URL(string: "https://image.tmdb.org/t/p/w500" + posterPathString)!
        cell.posterImageView.af_setImage(withURL: posterUrl)
        return cell
    }
    // This method updates filteredData based on the text in the Search Box
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // When there is no text, filteredData is the same as the original data
        // When user has entered text into the search box
        // Use the filter method to iterate over all items in the data array
        // For each item, return true if the item should be included and false if the
        // item should NOT be included
        filteredMovies = searchText.isEmpty ? movies : movies.filter { (item: [String:Any]) -> Bool in
            // If dataItem matches the searchText, return true to include it
            let title = item["title"] as! String
            return title.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        }
        
        tableView.reloadData()
    }
   }
