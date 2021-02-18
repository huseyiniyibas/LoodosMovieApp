//
//  DetailsContracts.swift
//  LoodosMovieApp
//
//  Created by Hüseyin on 17.02.2021.
//

import Foundation

enum DetailsViewModelOutput {
    case showAlert(_ error: String)
    case movie(_ movies: Movie)
}

enum DetailsViewRoute {
    case back
}

protocol DetailsViewModelDelegate: class {
    func viewModelOutput(output: DetailsViewModelOutput)
    func navigate(to route: DetailsViewRoute)
}

protocol DetailsViewModelProtocol: class {
    var delegate: DetailsViewModelDelegate? { get set }
    
    func searchMovie(with imdb: String)
    func go(to viewController: DetailsViewRoute)
}
