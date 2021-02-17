//
//  BaseBuilder.swift
//  LoodosMovieApp
//
//  Created by Hüseyin on 17.02.2021.
//

import UIKit

class BaseBuilder: NSObject {
    class func load<T: UIViewController>(appStoryboard: AppSceneName, viewController: String) -> T {
        let storyboard = UIStoryboard(name: appStoryboard.rawValue, bundle: nil)

        if let T = storyboard.instantiateViewController(withIdentifier: viewController) as? T {
            return T
        }

        return T()
    }
}
