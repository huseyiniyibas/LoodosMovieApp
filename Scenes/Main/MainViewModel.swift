//
//  MainViewModel.swift
//  LoodosMovieApp
//
//  Created by Hüseyin on 17.02.2021.
//

import Foundation

final class MainViewModel: MainViewModelProtocol {
    weak var delegate: MainViewModelDelegate?
    
    
    
    func go(to viewController: MainViewRoute) {
        delegate?.navigate(to: viewController)
    }
}
