//
//  LikedMovies.swift
//  MovieApp
//
//  Created by Tolgahan Sonmez on 2.03.2023.
//

import Foundation
// repository ne işe yarar
struct LikedMovies: Codable {
    
    static var shared = LikedMovies()
    
    var likedMovies : [TopMoviesResults] = []
    
    //daha önce arrayde var mı yok mu
    func isLiked(movie: TopMoviesResults)-> Bool {
        if likedMovies.contains(where: {$0.id == movie.id}) {
            return true
        }
        else {
            return false
        }
    }
    
    mutating func like(movie: TopMoviesResults) {
        
        if isLiked(movie: movie) {
            return
        }
        
        saveLikedLocal()
        likedMovies.append(movie)
        print(likedMovies.count)
        
    }
    
    
    mutating func unlike(movie: TopMoviesResults){
        
        if !isLiked(movie: movie) {
            return
        }
        
        //kendisine gelen filmi arraydan kaldırcak
        likedMovies = likedMovies.filter({ $0.id != movie.id})
        saveLikedLocal()
       
    }
    
    
    func saveLikedLocal() {
        //NSuserdefault string tutabildiğpi için arraytostring
        let likedMovies = arrayToString(with: likedMovies)
        //locale kayıt
        UserDefaults.standard.set(likedMovies, forKey: "savedMovies")
        print(likedMovies)
        
    }
    
    mutating func getLikedMoviesFromLocal() {
        //string olarak localde tuttugumuz veri
        if let savedString = UserDefaults.standard.object(forKey: "savedMovies") as? String {
            let likedMoviesArray = stringToArray(with: savedString)
            self.likedMovies = likedMoviesArray
        }
    }
    
    func arrayToString(with array: [TopMoviesResults])-> String {
        //encode ile veriyi şifrelenip stringe dönüştürüldü
        let encoder = JSONEncoder()
        if let jsonData : Data = try? encoder.encode(array) {
            let dataString = String(data: jsonData, encoding: .utf8)
            return dataString!
        }
        return " "
    }
    
    func stringToArray(with string: String)-> [TopMoviesResults] {
        let decoder = JSONDecoder()
        if let jdata = string.data(using: .utf8) {
            let dataArray = try? decoder.decode([TopMoviesResults].self, from: jdata)
            return dataArray ?? []
        }
        
        return []
    }
   
}
