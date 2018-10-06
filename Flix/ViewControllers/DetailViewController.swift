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
    
    var movie: Movie?
    override func viewDidLoad() {
        super.viewDidLoad()
        if let movie = movie {
            titleLabel.text = movie.title
            releaseDateLabel.text = movie.releaseDate
            overviewLabel.text = movie.overview
            let posterUrl = movie.posterUrl!
            let backdropUrlString = movie.backdropUrl!
            posterImageView.af_setImage(withURL: posterUrl)
            backDropImageView.af_setImage(withURL: backdropUrlString)
        }
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
