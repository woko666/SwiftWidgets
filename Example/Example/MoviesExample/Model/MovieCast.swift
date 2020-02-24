//
//  MovieDetails.swift
//  Example
//
//  Created by woko on 20/02/2020.
//

import Foundation

// swiftlint:disable identifier_name
struct MovieCast: Codable {
    /// Id from db
    var id: Int
    var character: String?
    var name: String
    var profile_path: String?
}
