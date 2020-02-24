//
//  WidgetMaker.swift
//  Example
//
//  Created by woko on 16/02/2020.
//

import Foundation
import UIKit

protocol WidgetMaker: WidgetContainer {
    
}

extension WidgetMaker {
    @discardableResult func addHeader(_ text: String) -> LabelWidget {
        return addWidget(LabelWidget.self) {
            $0.text.text = text
            $0.text.font = Settings.Font.with(size: 26, weight: .bold)
            $0.padding.vertical = Settings.Offset.basic2
            $0.padding.horizontal = Settings.Offset.basic3
        }
    }
    
    @discardableResult func addTitle(_ text: String, topPadding: Float = Settings.Offset.basic2) -> LabelWidget {
        return addWidget(LabelWidget.self) {
            $0.text.text = text
            $0.text.font = Settings.Font.with(size: 22, weight: .bold)
            $0.padding.vertical = Settings.Offset.basic2
            $0.padding.horizontal = Settings.Offset.basic3
            $0.color.background = Settings.Color.lightGray
        }
    }
    
    @discardableResult func addText(_ text: String) -> LabelWidget {
        return addWidget(LabelWidget.self) {
            $0.text.text = text
            $0.text.numberOfLines = 0
            $0.padding.horizontal = Settings.Offset.basic3
        }
    }
    
    @discardableResult func addImage(_ url: String) -> ImageWidget {
        return addWidget(ImageWidget.self) {
            $0.image.imageUrl = URL(string: url)
            $0.height = 200
            $0.padding.all = 0
        }
    }
    
    @discardableResult func addLoading(height: Float) -> LoadingWidget {
        return addWidget(LoadingWidget.self) {
            $0.height = height
        }
    }
    
    func getMovieWidget(_ movie: MovieViewModel) -> MovieWidget {
        return getWidget(MovieWidget.self) {
            $0.isEmbedded()
            $0.title.text = movie.name
            $0.title.font = Settings.Font.with(size: 18)
            $0.title.numberOfLines = 1
            $0.title.alignment = .center
            $0.image.imageUrl = URL(string: movie.imageUrl)
            $0.image.activityIndicator = true
        }
    }
    
    func getErrorLoadingWidget(height: Float) -> ImageWidget {
        return getWidget(ImageWidget.self) {
            $0.isEmbedded()
            $0.image.contentMode = .center
            $0.image.tintColor = Settings.Color.text
            $0.image.image = #imageLiteral(resourceName: "cloud_off")
            $0.height = height
        }
    }
    
    func addRating(_ rating: Double) {
        let container = addWidget(HContainerWidget.self) {
            $0.horizontalAlignment = .fill
        }
        
        container.model.addWidget(ImageWidget.self) {
            $0.size = 40
            $0.image.image = #imageLiteral(resourceName: "like")
            $0.image.contentMode = .scaleAspectFit
            $0.image.tintColor = Settings.Color.primary
        }
        
        container.model.addWidget(LabelWidget.self) {
            $0.text.text = String(format: "%d%% User Score", Int(round(rating)))
            $0.text.font = Settings.Font.with(size: 18, weight: .semibold)
            $0.padding.vertical = Settings.Offset.basic
            $0.padding.horizontal = 0
        }
    }
    
    func addActor(_ actor: MovieCastViewModel) {
        addWidget(ActorWidget.self) {
            if let imageUrl = actor.imageUrl {
                $0.image.imageUrl = URL(string: imageUrl)
            }
            $0.image.contentMode = .scaleAspectFill
        
            $0.name.text = actor.name
            $0.name.font = Settings.Font.with(size: 18, weight: .semibold)
            $0.character.text = actor.character
            $0.character.font = Settings.Font.with(size: 14)
            $0.character.color = Settings.Color.darkGray
            $0.padding.vertical = Settings.Offset.basic2
            $0.padding.horizontal = Settings.Offset.basic2
            
            $0.accessory.type = .disclosureIndicator
            $0.separator.enabled = true
        }
    }
}
