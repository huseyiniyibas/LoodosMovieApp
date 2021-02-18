//
//  SplashScreenBuilder.swift
//  LoodosMovieApp
//
//  Created by Hüseyin on 18.02.2021.
//

import Foundation

final class SplashScreenBuilder: BaseBuilder {
    static func make() -> SplashScreenViewController {
        let controller: SplashScreenViewController = self.load(appStoryboard: .splashScreen, viewController: "SplashScreen")
        
        return controller
    }
}
