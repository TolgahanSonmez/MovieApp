//
//  LikedViewController.swift
//  MovieApp
//
//  Created by Tolgahan Sonmez on 28.02.2023.
//

import UIKit
import SDWebImage

class LikedMoviesViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource{
    
    @IBOutlet weak var likedcollectionview: UICollectionView!
    private let noLikedMovieView = NoLikedMovieView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let widthSize = UIScreen.main.bounds.width/3-4
        let heightSize = UIScreen.main.bounds.height/3.3-4
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: widthSize, height: heightSize)
        layout.minimumLineSpacing = 4
        layout.minimumInteritemSpacing = 4
        likedcollectionview.collectionViewLayout = layout
        likedcollectionview.dataSource = self
        likedcollectionview.delegate = self
        LikedMovies.shared.getLikedMoviesFromLocal()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        noLikedMovieView.frame = CGRect(x: (view.width-150)/2, y: (view.height-150)/2, width: 150, height: 150)
        
    }
    
    func updateUI() {
        if LikedMovies.shared.likedMovies.isEmpty {
            view.addSubview(noLikedMovieView)
            noLikedMovieView.delegate = self
            noLikedMovieView.configure(viewModel: NoViewModel(
                text: "Filmlere Gözat",
                actionTitle: "Gözat"))
            noLikedMovieView.isHidden = false
            
            likedcollectionview.isHidden = true
        } else {
            
            likedcollectionview.reloadData()
            noLikedMovieView.isHidden = true
            likedcollectionview.isHidden = false
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateUI()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return LikedMovies.shared.likedMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let cell = likedcollectionview.dequeueReusableCell(withReuseIdentifier: "favCell", for: indexPath) as? LikedMoviesCollectionViewCell
        let favMovies = LikedMovies.shared.likedMovies[indexPath.row]
        
        cell?.favImage.sd_setImage(with: URL(string: "https://image.tmdb.org/t/p/w500"+favMovies.backdrop_path!))
        cell?.favTiitle.text = favMovies.title
        cell?.favPopularity.text = String(favMovies.popularity)
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedMovie = LikedMovies.shared.likedMovies[indexPath.row]
        let vc = storyboard?.instantiateViewController(withIdentifier: "movieDetail") as? MovieDetailViewController
        vc?.moviesDetails = selectedMovie
        vc?.modalPresentationStyle = .fullScreen
        vc?.modalTransitionStyle = .crossDissolve
        self.navigationController?.pushViewController(vc!, animated: true)
    }
}

extension LikedMoviesViewController: NoLikedMovieDelegate {
    func goToMoviesPage(_ noLikedMovieView: NoLikedMovieView) {
        tabBarController?.selectedIndex = 0
    }
}
