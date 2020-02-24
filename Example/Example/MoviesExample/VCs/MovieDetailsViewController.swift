//
//  MovieDetailsViewController.swift
//  Example
//
//  Created by woko on 17/02/2020.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class MovieDetailsViewController: WidgetTableViewController, WidgetMaker {
    let viewModel = MovieDetailsViewModel()
    let disposeBag = DisposeBag()
    
    let loadingHeight: Float = 200
    
    var movie: MovieViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.movie = movie
        
        setupDataBindings()
        viewModel.loadValues()
    }
    
    func setupDataBindings() {
        viewModel.cast.subscribe(onNext: { [weak self] connection in
            guard let self = self else { return }
            
            switch connection {
            case .connecting:
                self.replaceWidgets {
                    self.addWidget(LoadingWidget.self) {
                        $0.height = self.loadingHeight
                    }
                }
            case .error(let e):
                print(e)
                self.replaceWidgets {
                    let error = self.getErrorLoadingWidget(height: self.loadingHeight)
                    error.model.tapped = { [weak self] in
                        self?.viewModel.loadValues()
                    }
                    self.addWidget(error)
                }
                
            case .done(let items):
                self.replaceWidgets {
                    self.loadWidgets(items)
                }
            }
        }).disposed(by: disposeBag)
    }
        
    func loadWidgets(_ cast: [MovieCastViewModel]) {
        addImage(movie.horizontalUrl)
        addHeader(movie.name)
        addRating(movie.rating * 10.0)
        addText(movie.overview)
        addSpace(Settings.Offset.basic2)
        cast.filter { $0.imageUrl != nil }.forEach { actor in
            addActor(actor)
        }
    }
}
