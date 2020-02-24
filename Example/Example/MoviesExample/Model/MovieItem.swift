//
//  MovieItem.swift
//  Example
//
//  Created by woko on 16/02/2020.
//

import Foundation

// swiftlint:disable identifier_name
struct MovieItem: Codable {
    /// Id from db
    var id: Int
    /// Principal title of the Movie
    var title: String
    /// Average from votes
    var vote_average: Double
    /// Synopsis of the movie or Tv Show
    var overview: String
    /// Release date
    var release_date: String
    /// Image for poster portrait
    var poster_path: String
    /// Image for landscape
    var backdrop_path: String?
    /// Genre of the item
    var genre_ids: [Int]
}
