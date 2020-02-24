//
//  MovieListViewController.swift
//  Example
//
//  Created by woko on 16/02/2020.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class MovieListViewController: WidgetTableViewController, WidgetMaker {
    let viewModel = MovieListViewModel()
    let disposeBag = DisposeBag()
    
    let movieWidgetWidth: Float = 180
    let movieCategoryHeight: Float = 300
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Settings.initDefaults(MovieAppConfig())
        
        //animateUpdates = false
        loadWidgets()
        viewModel.loadValues()
    }
    
    func loadMovieItems(_ items: [MovieViewModel], widgetIndex: WidgetIndex) {
        let container = getWidget(HorizontalScrollContainerWidget.self) {
            $0.itemWidth = movieWidgetWidth
            $0.height = movieCategoryHeight
            $0.itemMargin = Settings.Offset.basic
            $0.padding.all = Settings.Offset.basic2
        }
        items.forEach { item in
            let widget = getMovieWidget(item)
            widget.model.isEmbedded()
            widget.model.tapped = { [weak self] in
                let vc = MovieDetailsViewController()
                vc.movie = item
                self?.navigationController?.pushViewController(vc, animated: true)
            }
            container.model.addWidget(widget)
        }
        replaceWidget(container, at: widgetIndex)
    }
    
    func setupMovieCategory(_ name: String, data: BehaviorRelay<ConnectionState<[MovieViewModel]>>, reload: @escaping () -> Void) {
        addTitle(name)
        addSpace(movieCategoryHeight)
        guard let widgetIndex = currentIndex else { return }
        
        data.observeOn(MainScheduler.instance).subscribe(onNext: { [weak self] connection in
            guard let self = self else { return }
            
            switch connection {
            case .connecting:
                let loading = self.getWidget(LoadingWidget.self) {
                    $0.height = self.movieCategoryHeight
                }
                self.replaceWidget(loading, at: widgetIndex)
            case .error:
                let error = self.getErrorLoadingWidget(height: self.movieCategoryHeight)
                error.model.tapped = reload
                self.replaceWidget(error, at: widgetIndex)
            case .done(let items):
                self.loadMovieItems(items, widgetIndex: widgetIndex)
            }
        }).disposed(by: disposeBag)
    }
    
    func loadWidgets() {
        setupMovieCategory("Popular", data: viewModel.popular) { [weak self] in self?.viewModel.loadPopular() }
        setupMovieCategory("Top Rated", data: viewModel.topRated) { [weak self] in self?.viewModel.loadTopRated() }
        setupMovieCategory("Upcoming", data: viewModel.upcoming) { [weak self] in self?.viewModel.loadUpcoming() }
    }
}
