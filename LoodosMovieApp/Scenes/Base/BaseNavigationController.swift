//
//  BaseNavigationController.swift
//  LoodosMovieApp
//
//  Created by Hüseyin on 17.02.2021.
//

import UIKit

class BaseNavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }

    func setup() {
        self.setNavigationBarHidden(true, animated: false)
    }
}
