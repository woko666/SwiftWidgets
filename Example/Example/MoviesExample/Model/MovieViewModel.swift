//
//  MovieViewModel.swift
//  Example
//
//  Created by woko on 16/02/2020.
//

import Foundation

struct MovieViewModel {
    var id: Int
    var name: String
    var rating: Double
    var imageUrl: String
    var horizontalUrl: String
    var overview: String
    
    init(_ item: MovieItem) {
        id = item.id
        name = item.title
        imageUrl = MovieAppConstants.imageBaseUrl + "w300" + item.poster_path
        horizontalUrl = MovieAppConstants.imageBaseUrl + "w500" + (item.backdrop_path ?? item.poster_path)
        rating = item.vote_average
        overview = item.overview
    }
}
