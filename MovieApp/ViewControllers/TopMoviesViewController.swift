//
//  MainVCViewController.swift
//  MovieApp
//
//  Created by Tolgahan Sonmez on 28.02.2023.
//

import UIKit
import SDWebImage

class TopMoviesViewController: UIViewController{
    
    @IBOutlet weak var MoviesCollectionView: UICollectionView!
    //@IBOutlet weak var moviesCollectionView: UICollectionView!
    var movie : TopMovies?
    var isLoadingMore = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Movies"
        MoviesCollectionView.dataSource = self
        MoviesCollectionView.delegate = self
        getTopMoviesData()
    }
    
    func getTopMoviesData() {
        APICaller.shared.getTopMovies(with: 0 ) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let model):
                    self.movie = model
                    self.MoviesCollectionView.reloadData()
                    print(model)
                case .failure(let eror):
                    print(eror)
                }
            }
        }
    }
    
    func getMoreMovies() {
        if self.isLoadingMore {
            return
        }
        
        self.isLoadingMore = true
        let page = self.movie?.page ?? 0
        
        APICaller.shared.getTopMovies(with: page) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let model):
                    self.movie?.results.append(contentsOf: model.results)
                    self.MoviesCollectionView.reloadData()
                    self.isLoadingMore = false
                case .failure(let eror):
                    print(eror)
                }
            }
        }
    }
}

extension TopMoviesViewController: UICollectionViewDelegate,UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movie?.results.count ?? 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let cell = self.MoviesCollectionView.dequeueReusableCell(
            withReuseIdentifier: "cell",
            for: indexPath) as? TopMoviesCollectionViewCell
        
        if let movies = self.movie?.results[indexPath.row] {
            cell?.layer.borderColor = UIColor.gray.cgColor
            cell?.layer.borderWidth = 0.5
            cell?.layer.cornerRadius = 10
            
            cell?.movieImage.sd_setImage(with: URL(string: "https://image.tmdb.org/t/p/w500"+(movies.poster_path)))
            cell?.movieName.text = movies.title
            cell?.releaseDate.text = movies.release_date
        }
        
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedMoviesDetails = movie?.results[indexPath.row]
        let vc = storyboard?.instantiateViewController(withIdentifier: "movieDetail") as? MovieDetailViewController
        vc?.moviesDetails = selectedMoviesDetails
        vc?.modalPresentationStyle = .fullScreen
        vc?.modalTransitionStyle = .crossDissolve
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        print(indexPath.row)
        if indexPath.row == (self.movie?.results.count ?? 1)-4 {
            getMoreMovies()
            self.movie?.page += 1
        }
    }
}
