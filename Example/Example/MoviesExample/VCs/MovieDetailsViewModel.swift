//
//  MovieDetailsViewModel.swift
//  Example
//
//  Created by woko on 20/02/2020.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class MovieDetailsViewModel {
    let moviesService = MoviesServiceMoya()
    let disposeBag = DisposeBag()
    
    var movie: MovieViewModel!
    var cast = BehaviorRelay<ConnectionState<[MovieCastViewModel]>>(value: .connecting)
    
    func loadValues() {
        cast.accept(.connecting)
        moviesService.getMovieCast(movie.id).delay(.milliseconds(1500), scheduler: MainScheduler.instance).subscribe( onNext: { items in
            self.cast.accept(.done(items.map { MovieCastViewModel($0) }))
        }, onError: { e in
            self.cast.accept(.error(e))
        }).disposed(by: disposeBag)
    }
}
