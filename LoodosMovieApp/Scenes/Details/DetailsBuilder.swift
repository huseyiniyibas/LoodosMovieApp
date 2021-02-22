//
//  DetailsBuilder.swift
//  LoodosMovieApp
//
//  Created by Hüseyin on 17.02.2021.
//

import Foundation

final class DetailsBuilder: BaseBuilder {
    static func make(imdb: String) -> DetailsViewController {
        let controller: DetailsViewController = self.load(appStoryboard: .details, viewController: "Details")
        controller.viewModel = DetailsViewModel()
        controller.imdb = imdb
        
        return controller
    }
}
