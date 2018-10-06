//
//  Movie.swift
//  Flix
//
//  Created by Andre Campbell on 10/6/18.
//  Copyright © 2018 Andre Campbell. All rights reserved.
//
import Foundation

class Movie {
    var title: String
    var overview: String
    var posterUrl: URL?
    var backdropUrl: URL?
    var releaseDate: String
    
    init(dictionary: [String: Any]) {
        title = dictionary["title"] as? String ?? "No title"
        overview = dictionary["overview"] as? String ?? "No overview"
        releaseDate = dictionary["release_date"] as! String
        let baseURL = "https://image.tmdb.org/t/p/w500"
        let posterPathString = dictionary["poster_path"] as! String
        let backdropPathString = dictionary["backdrop_path"] as! String
        posterUrl = URL(string: baseURL + posterPathString)!
        backdropUrl = URL(string: baseURL + backdropPathString)!
        
        
        
    }
    
    class func movies(dictionaries: [[String: Any]]) -> [Movie] {
        var movies: [Movie] = []
        for dictionary in dictionaries {
            let movie = Movie(dictionary: dictionary)
            movies.append(movie)
        }
        
        return movies
    }
}
