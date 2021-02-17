//
//  MainContracts.swift
//  LoodosMovieApp
//
//  Created by Hüseyin on 17.02.2021.
//

import Foundation

enum MainViewModelOutput {
    case showAlert(_ response: String)
}

enum MainViewRoute {
    case details
}

protocol MainViewModelDelegate: class {
    func viewModelOutput(output: MainViewModelOutput)
    func navigate(to route: MainViewRoute)
}

protocol MainViewModelProtocol: class {
    var delegate: MainViewModelDelegate? { get set }
    
    func go(to viewController: MainViewRoute)
}
