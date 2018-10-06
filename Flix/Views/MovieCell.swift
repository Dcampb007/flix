//
//  MovieCell.swift
//  Flix
//
//  Created by Andre Campbell on 9/1/18.
//  Copyright © 2018 Andre Campbell. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    var movie: Movie! {
        didSet {
            // Initialization code
            titleLabel.text = movie.title
            overviewLabel.text = movie.overview
            let posterUrl = movie.posterUrl!
            posterImageView.af_setImage(withURL: posterUrl)
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
