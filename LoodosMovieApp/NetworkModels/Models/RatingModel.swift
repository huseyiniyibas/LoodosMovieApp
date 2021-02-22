//
//  RatingModel.swift
//  LoodosMovieApp
//
//  Created by Hüseyin on 17.02.2021.
//

import Foundation

struct Rating {
    let Source: String?
    let Value: String?
}

extension Rating: Decodable {}
