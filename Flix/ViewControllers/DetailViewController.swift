//
//  DetailViewController.swift
//  Flix
//
//  Created by Andre Campbell on 9/4/18.
//  Copyright © 2018 Andre Campbell. All rights reserved.
//

import UIKit
import AlamofireImage

class DetailViewController: UIViewController {

    // outlets
    @IBOutlet weak var backDropImageView: UIImageView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    
    var movie: [String: Any]?
    override func viewDidLoad() {
        super.viewDidLoad()
        if let movie = movie {
            titleLabel.text = movie["title"] as? String
            releaseDateLabel.text = movie["release_date"] as? String
            overviewLabel.text = movie["overview"] as? String
            let backdropPathString = movie["backdrop_path"] as! String
            let posterPathString = movie["poster_path"] as! String
            let baseURLString = "https://image.tmdb.org/t/p/w500"
            let posterUrl = URL(string: baseURLString + posterPathString)!
            let backdropUrlString = URL(string: baseURLString + backdropPathString)!
            posterImageView.af_setImage(withURL: posterUrl)
            backDropImageView.af_setImage(withURL: backdropUrlString)
        }
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
