//
//  DetailsViewController.swift
//  LoodosMovieApp
//
//  Created by Hüseyin on 17.02.2021.
//

import Alamofire
import UIKit

class DetailsViewController: BaseViewController {
    // MARK: - IBOutlet
    @IBOutlet private weak var blurPosterImageView: UIImageView!
    @IBOutlet private weak var posterImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var yearLabel: UILabel!
    @IBOutlet private weak var countryLabel: UILabel!
    @IBOutlet private weak var plotLabel: UILabel!
    @IBOutlet private weak var genreLabel: UILabel!
    @IBOutlet private weak var actorsLabel: UILabel!
    @IBOutlet private weak var ratingsStackView: UIStackView!
    @IBOutlet private weak var awardsLabel: UILabel!
    @IBOutlet private weak var productionLabel: UILabel!
    @IBOutlet private weak var writerLabel: UILabel!
    @IBOutlet private weak var boxOfficeLabel: UILabel!
    @IBOutlet private weak var ratedLabel: UILabel!
    @IBOutlet private weak var releasedLabel: UILabel!
    @IBOutlet private weak var runTimeLabel: UILabel!
    @IBOutlet private weak var directorLabel: UILabel!
    @IBOutlet private weak var languageLabel: UILabel!
    @IBOutlet private weak var websiteLabel: UILabel!
    
    // MARK: - Variables
    var viewModel: DetailsViewModelProtocol? {
        didSet {
            viewModel?.delegate = self
        }
    }
    var imdb: String?
    
    // MARK: - View
    override func viewDidLoad() {
        super.viewDidLoad()

        setDelegates()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setUI()
        setData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        blurPosterImageView.isHidden = true
    }
    
}

// MARK: - Delegates

// MARK: - Functions
extension DetailsViewController {
    private func setUI() {
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.tintColor = .black
        
        posterImageView.layer.cornerRadius = 12
        posterImageView.layer.borderWidth = 1
        posterImageView.layer.borderColor = UIColor.systemYellow.cgColor
    }
    
    private func setData() {
        if let imdb = imdb {
            showLoading()
            viewModel?.searchMovie(with: imdb)
        }
    }
    
    private func setDelegates() {
        
    }
    
    private func setMovie(_ movie: Movie) {
        DispatchQueue.main.async {
            self.title = movie.Title
            self.titleLabel.text = movie.Title
            self.yearLabel.text = movie.Year
            self.countryLabel.text = movie.Country
            self.plotLabel.text = movie.Plot
            self.genreLabel.text = movie.Genre
            self.actorsLabel.text = movie.Actors
            self.awardsLabel.text = movie.Awards
            self.productionLabel.text = movie.Production
            self.writerLabel.text = movie.Writer
            self.boxOfficeLabel.text = movie.BoxOffice
            self.ratedLabel.text = movie.Rated
            self.releasedLabel.text = movie.Released
            self.runTimeLabel.text = movie.Runtime
            self.directorLabel.text = movie.Director
            self.languageLabel.text = movie.Language
            self.websiteLabel.text = movie.Website
            
            if let ratings = movie.Ratings {
                for rating in ratings {
                    let sourceLabel = UILabel()
                    sourceLabel.text = rating.Source
                    sourceLabel.textColor = UIColor.systemGray4
                    sourceLabel.font = UIFont.systemFont(ofSize: 15)
                    let valueLabel = UILabel()
                    valueLabel.text = rating.Value
                    valueLabel.textColor = UIColor.systemGray5
                    valueLabel.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
                    let ratingStackView = UIStackView(arrangedSubviews: [sourceLabel, valueLabel])
                    ratingStackView.distribution = .equalSpacing
                    self.ratingsStackView.insertArrangedSubview(ratingStackView, at: 0)
                }
            }
            
            if let url = movie.Poster {
                self.setPosterImage(image: url)
            }
        }
    }
    
    private func setPosterImage(image url: String) {
        AF.request(url).responseImage { response in
            if case .success(let image) = response.result {
                self.posterImageView.image = image
                self.setBlurPosterImage(image: image)
            } else {
                let image = UIImage(named: "No Image")
                self.posterImageView.image = image
                self.setBlurPosterImage(image: image)
            }
        }
    }
    
    private func setBlurPosterImage(image: UIImage?) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            if let image = image { self.blurPosterImageView.image = image }
            let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            blurEffectView.frame = self.blurPosterImageView.bounds
            blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            self.blurPosterImageView.addSubview(blurEffectView)
        }
    }
}

// MARK: - Network
extension DetailsViewController: DetailsViewModelDelegate {
    func viewModelOutput(output: DetailsViewModelOutput) {
        DispatchQueue.main.async {
            self.hideLoading()
            
            switch output {
            case .showAlert(let error):
                self.alert(message: error)
            case .movie(let movie):
                self.setMovie(movie)
            }
        }
    }
    
    func navigate(to route: DetailsViewRoute) {
        DispatchQueue.main.async {
            switch route {
            case .back:
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
}
