//
//  DetailsViewModel.swift
//  LoodosMovieApp
//
//  Created by Hüseyin on 17.02.2021.
//

import Alamofire

final class DetailsViewModel: DetailsViewModelProtocol {
    weak var delegate: DetailsViewModelDelegate?
    
    func searchMovie(with imdb: String) {
        let parameters = [
            "apikey": Constants.API_KEY,
            "i": imdb
        ]
        
        AF.request(Constants.BASE_URL, parameters: parameters).responseDecodable(of: Movie.self) { response in
            if let movie = response.value {
                self.delegate?.viewModelOutput(output: .movie(movie))
            }
        }
    }
    
    func go(to viewController: DetailsViewRoute) {
        delegate?.navigate(to: viewController)
    }
}
