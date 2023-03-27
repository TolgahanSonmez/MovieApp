//
//  MovieDetailViewController.swift
//  MovieApp
//
//  Created by Tolgahan Sonmez on 1.03.2023.
//

import UIKit
import SDWebImage
import RealmSwift

class MovieDetailViewController: UIViewController {
    
    @IBOutlet weak var movieDetailImage: UIImageView!
    @IBOutlet weak var deneme: UILabel!
    var moviesDetails: TopMoviesResults?
    var likedIMG =   UIImage(named:"liked")
    var likeIMG  =   UIImage(named :"like")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = moviesDetails?.title
        movieDetailImage.layer.masksToBounds = true
        movieDetailImage.layer.cornerRadius = 4
        movieDetailImage.contentMode = .scaleAspectFill
        deneme.text = (moviesDetails?.overview ?? "")
        movieDetailImage.sd_setImage(with: URL(string: "https://image.tmdb.org/t/p/w500"+(moviesDetails?.backdrop_path ?? "")))
        self.checklikeButton()
    }
    
    func checklikeButton() {
        if LikedMovies.shared.isLiked(movie: moviesDetails!) {
            let likedButton = UIBarButtonItem(image:likedIMG, style: .done, target: self, action: #selector(addFavorite))
            navigationItem.rightBarButtonItems = [likedButton]
        }else{
            let unlikeButton = UIBarButtonItem(image:likeIMG, style: .done, target:self, action :#selector(addFavorite))
            navigationItem.rightBarButtonItems = [unlikeButton]
        }
    }
    
    @objc func addFavorite() {
        if LikedMovies.shared.isLiked(movie: self.moviesDetails!) {
            LikedMovies.shared.unlike(movie: self.moviesDetails!)
            checklikeButton()
        } else {
            LikedMovies.shared.like(movie: self.moviesDetails!)
            checklikeButton()
        }
    }
}
