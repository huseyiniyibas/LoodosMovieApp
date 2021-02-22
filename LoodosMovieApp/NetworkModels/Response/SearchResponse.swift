//
//  SearchResponse.swift
//  LoodosMovieApp
//
//  Created by Hüseyin on 17.02.2021.
//

import Foundation

struct SearchResponse {
    var Search: [Movie]?
    var totalResults: String?
    var Response: String?
    var Error: String?
}

extension SearchResponse: Decodable {}
