//
//  MoviesServiceMoya.swift
//  Example
//
//  Created by woko on 16/02/2020.
//

import Foundation
import Moya
import RxSwift
import Alamofire

class MoviesServiceMoya {
    var provider = MoyaProvider<MoviesProvider>(plugins: [NetworkLoggerPlugin(configuration: NetworkLoggerPlugin.Configuration(logOptions: .verbose))])
    
    fileprivate struct GetPopularMoviesResponse: Codable {
        var results: [MovieItem]
    }
    
    func getPopularMovies() -> Observable<[MovieItem]> {
        return provider.rx.request(.getPopularMovies)
            .checkStatusCode()
            .mapJson(GetPopularMoviesResponse.self)
            .map({ item in
                item.results
            })
            .asObservable()
    }
    
    func getTopRatedMovies() -> Observable<[MovieItem]> {
        return provider.rx.request(.getTopRatedMovies)
            .checkStatusCode()
            .mapJson(GetPopularMoviesResponse.self)
            .map({ item in
                item.results
            })
            .asObservable()
    }
    
    func getUpcomingMovies() -> Observable<[MovieItem]> {
        return provider.rx.request(.getUpcomingMovies)
            .checkStatusCode()
            .mapJson(GetPopularMoviesResponse.self)
            .map({ item in
                item.results
            })
            .asObservable()
    }
    
    fileprivate struct GetMovieCastResponse: Codable {
        var cast: [MovieCast]
    }
    
    func getMovieCast(_ id: Int) -> Observable<[MovieCast]> {
        return provider.rx.request(.getMovieCast(id: id))
            .checkStatusCode()
            .mapJson(GetMovieCastResponse.self)
            .map({ item in
                item.cast
            })
            .asObservable()
    }
}
