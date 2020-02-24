//
//  MovieCastViewModel.swift
//  Example
//
//  Created by woko on 20/02/2020.
//

import Foundation

struct MovieCastViewModel {
    var name: String
    var character: String?
    var imageUrl: String?
    
    init(_ item: MovieCast) {
        name = item.name
        character = item.character
        if let path = item.profile_path {
            imageUrl = MovieAppConstants.imageBaseUrl + "w300" + path
        }
    }
}
