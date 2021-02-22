//
//  MainViewModel.swift
//  LoodosMovieApp
//
//  Created by Hüseyin on 17.02.2021.
//

import Alamofire

final class MainViewModel: MainViewModelProtocol {
    weak var delegate: MainViewModelDelegate?
    
    func searchMovie(with keyword: String, showError: Bool, page: Int) {
        let parameters = [
            "apikey": Constants.API_KEY,
            "s": keyword,
            "page": page,
            "type": "movie"
        ] as [String : Any]
        
        AF.request(Constants.BASE_URL, parameters: parameters).responseDecodable(of: SearchResponse.self) { response in
            if let responseValue = response.value {
                if let movies = responseValue.Search, page == 1 {
                    self.delegate?.viewModelOutput(output: .movies(movies))
                } else if let movies = responseValue.Search {
                    self.delegate?.viewModelOutput(output: .addMovies(movies))
                } else if let error = responseValue.Error, showError, page == 1 {
                    self.delegate?.viewModelOutput(output: .showAlert(error))
                } else if page == 1 {
                    self.delegate?.viewModelOutput(output: .noAlert)
                }
            }
        }
    }
    
    func go(to viewController: MainViewRoute) {
        delegate?.navigate(to: viewController)
    }
}
