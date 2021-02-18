//
//  MainContracts.swift
//  LoodosMovieApp
//
//  Created by Hüseyin on 17.02.2021.
//

import Foundation

enum MainViewModelOutput {
    case noAlert
    case showAlert(_ error: String)
    case movies(_ movies: [Movie])
    case addMovies(_ movies: [Movie])
}

enum MainViewRoute {
    case details(imdb: String)
}

protocol MainViewModelDelegate: class {
    func viewModelOutput(output: MainViewModelOutput)
    func navigate(to route: MainViewRoute)
}

protocol MainViewModelProtocol: class {
    var delegate: MainViewModelDelegate? { get set }
    
    func searchMovie(with keyword: String, showError: Bool, page: Int)
    func go(to viewController: MainViewRoute)
}
