//
//  CollectionViewCell.swift
//  MovieApp
//
//  Created by Tolgahan Sonmez on 1.03.2023.
//

import UIKit
import SDWebImage

class TopMoviesCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var movieImage: UIImageView!
    
    @IBOutlet weak var movieName: UILabel!
    
    @IBOutlet weak var releaseDate: UILabel!
    
    
    
    func configure(with model : TopMoviesViewModel) {
        movieImage.sd_setImage(with: model.movieImage)
        movieName.text = model.movieTitle
        releaseDate.text = model.movieReleaseDate
    }
    
}
