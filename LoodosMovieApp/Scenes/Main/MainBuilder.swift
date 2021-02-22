//
//  MainBuilder.swift
//  LoodosMovieApp
//
//  Created by Hüseyin on 17.02.2021.
//

import Foundation

final class MainBuilder: BaseBuilder {
    static func make() -> MainViewController {
        let controller: MainViewController = self.load(appStoryboard: .main, viewController: "Main")
        controller.viewModel = MainViewModel()
        
        return controller
    }
}
