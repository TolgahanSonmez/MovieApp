//
//  TopMovies.swift
//  MovieApp
//
//  Created by Tolgahan Sonmez on 1.03.2023.
//

import Foundation

struct TopMovies: Codable {
    var page : Int
    var total_pages : Int
    var total_results : Int
    var results : [TopMoviesResults]
}

struct TopMoviesResults: Codable {
    var adult : Bool
    var backdrop_path : String?
    var genre_ids : [Int]
    var id : Int
    var original_language : String
    var original_title : String
    var overview : String
    var popularity : Double
    var poster_path : String
    var release_date : String
    var title : String
    var video : Bool
    var vote_average : Double
    var vote_count : Int
}



/*struct TopMoviesResponse: Codable {
    var page : Int
    var total_pages : Int
    var total_results : Int
    var results : [TopMoviesResultItem]
}

struct TopMoviesResultItem: Codable {
    var adult : Bool
    var backdrop_path : String?
    var genre_ids : [Int]
    var id : Int
    var original_language : String
    var original_title : String
    var overview : String
    var popularity : Double
    var poster_path : String
    var release_date : String
    var title : String
    var video : Bool
    var vote_average : Double
    var vote_count : Int
} */
