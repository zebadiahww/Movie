//
//  MovieInfoTableViewCell.swift
//  Movie
//
//  Created by Zebadiah Watson on 10/4/19.
//  Copyright © 2019 Zebadiah Watson. All rights reserved.
//

import UIKit

class MovieInfoTableViewCell: UITableViewCell {
    
    // Outlets
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var summaryText: UITextField!
    
    
    var movieItem: Results? {
        didSet {
            guard let item = movieItem else { return }
            titleLabel.text = item.title
            ratingLabel.text = "\(item.rating)"
            summaryText.text = item.overview
            posterImageView.image = nil
            MovieController.getPoster(item: item) { (image) in
                if let image = image {
                    DispatchQueue.main.async {
                        self.posterImageView.image = image
                    }
                } else {
                    print("image was nil")
                }
            }
        }
    }
}// End of Class
