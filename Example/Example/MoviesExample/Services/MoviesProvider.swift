//
//  MoviesProvider.swift
//  Example
//
//  Created by woko on 16/02/2020.
//

import Foundation
import Moya

enum MoviesProvider: TargetType {
    case getPopularMovies
    case getTopRatedMovies
    case getUpcomingMovies
    case getMovieCast(id: Int)
    
    var baseURL: URL {
        return URL(string: MovieAppConstants.apiBaseUrl)!
    }
    
    var path: String {
        switch self {
        case .getPopularMovies:
            return "/movie/popular"
        case .getTopRatedMovies:
            return "/movie/top_rated"
        case .getUpcomingMovies:
            return "/movie/upcoming"
        case .getMovieCast(let id):
            return "/movie/\(id)/credits"
        }
    }
    var method: Moya.Method {
        return .get
    }
    var task: Task {
        return .requestParameters(parameters: [
            "api_key": MovieAppConstants.apiKey
        ], encoding: URLEncoding.default)
    }
    var headers: [String: String]? {
        return nil
    }
    var sampleData: Data {
        return Data()
    }
}
