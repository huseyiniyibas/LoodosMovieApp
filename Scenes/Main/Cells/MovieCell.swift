//
//  MovieCell.swift
//  LoodosMovieApp
//
//  Created by Hüseyin on 17.02.2021.
//

import Alamofire
import AlamofireImage
import UIKit

class MovieCell: UICollectionViewCell {
    // MARK: - IBOutlet
    @IBOutlet private weak var posterImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var yearLabel: UILabel!
    @IBOutlet private weak var typeLabel: UILabel!
    
    // MARK: - Variables
    
    // MARK: - View
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setUI()
    }
}

// MARK: - Functions
extension MovieCell {
    private func setUI() {
        posterImageView.layer.cornerRadius = 12
    }
    
    func setCell(_ movie: Movie) {
        titleLabel.text = movie.Title
        yearLabel.text = movie.Year
        typeLabel.text = movie.Type
        
        if let url = movie.Poster {
            setPosterImage(image: url)
        }
    }
    
    private func setPosterImage(image url: String) {
        AF.request(url).responseImage { response in
            if case .success(let image) = response.result {
                self.posterImageView.image = image
            } else {
                self.posterImageView.image = UIImage(named: "No Image")
            }
        }
    }
}
