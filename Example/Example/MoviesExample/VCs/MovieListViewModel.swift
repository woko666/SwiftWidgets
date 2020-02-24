//
//  MovieListViewModel.swift
//  Example
//
//  Created by woko on 16/02/2020.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class MovieListViewModel {
    let moviesService = MoviesServiceMoya()
    let disposeBag = DisposeBag()
    
    var popular = BehaviorRelay<ConnectionState<[MovieViewModel]>>(value: .connecting)
    var topRated = BehaviorRelay<ConnectionState<[MovieViewModel]>>(value: .connecting)
    var upcoming = BehaviorRelay<ConnectionState<[MovieViewModel]>>(value: .connecting)
    
    var isFirst = true
    
    func loadValues() {
        loadPopular()
        loadTopRated()
        loadUpcoming()
    }
    
    func loadPopular() {
        popular.accept(.connecting)
        moviesService.getPopularMovies().delay(.milliseconds(500), scheduler: MainScheduler.instance).subscribe( onNext: { items in
            self.popular.accept(.done(items.map { MovieViewModel($0) }))
        }, onError: { e in
            self.popular.accept(.error(e))
        }).disposed(by: disposeBag)
    }
    
    func loadTopRated() {
        topRated.accept(.connecting)
        moviesService.getTopRatedMovies().delay(.milliseconds(1500), scheduler: MainScheduler.instance).subscribe( onNext: { items in
            if self.isFirst {
                self.isFirst = false
                self.topRated.accept(.error(NetworkError.statusCodeError(code: 666)))
            } else {
                self.topRated.accept(.done(items.map { MovieViewModel($0) }))
            }
        }, onError: { e in
            self.topRated.accept(.error(e))
        }).disposed(by: disposeBag)
    }
    
    func loadUpcoming() {
        upcoming.accept(.connecting)
        moviesService.getUpcomingMovies().delay(.seconds(1), scheduler: MainScheduler.instance).subscribe( onNext: { items in
            self.upcoming.accept(.done(items.map { MovieViewModel($0) }))
        }, onError: { e in
            self.upcoming.accept(.error(e))
        }).disposed(by: disposeBag)
    }
}
