//
//  MainViewController.swift
//  LoodosMovieApp
//
//  Created by Hüseyin on 17.02.2021.
//

import Alamofire
import UIKit

class MainViewController: BaseViewController {
    // MARK: - IBOutlet
    @IBOutlet private weak var searchTextField: UITextField!
    @IBOutlet private weak var moviesCollectionView: UICollectionView!
    
    // MARK: - Variables
    var viewModel: MainViewModelProtocol? {
        didSet {
            viewModel?.delegate = self
        }
    }
    var movies: [Movie]?
    var page = 1
    
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
}

// MARK: - Delegate
extension MainViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        page = 1
        if let text = textField.text {
            showLoading()
            viewModel?.searchMovie(with: text, showError: false, page: page)
            moviesCollectionView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        }
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if let text = textField.text {
            page = 1
            let count = text.count
            
            if count < 3 {
                hideLoading()
                searchTextField.addRedBorder()
            } else {
                showLoading()
                viewModel?.searchMovie(with: text, showError: false, page: page)
                searchTextField.addGreenBorder()
            }
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        searchTextField.addGrayBorder()
        searchTextField.resignFirstResponder()
        
        guard let text = textField.text else { return }
        
        if !text.isEmpty, movies == nil {
            showLoading()
            viewModel?.searchMovie(with: text, showError: true, page: page)
        }
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        movies = nil
        moviesCollectionView.reloadData()
        searchTextField.text = ""
        searchTextField.resignFirstResponder()
        
        return false
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let movieCell = moviesCollectionView.dequeueReusableCell(withReuseIdentifier: "Movie Cell", for: indexPath) as? MovieCell {
            if let movies = movies {
                movieCell.setCell(movies[indexPath.row])
            }
            
            return movieCell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 120)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let movies = movies, movies.count > 9 * page {
            if indexPath.row + 1 == movies.count {
                page += 1
                if let text = searchTextField.text {
                    viewModel?.searchMovie(with: text, showError: true, page: page)
                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let movies = movies {
            guard let imdb = movies[indexPath.row].imdbID else { return  }
            viewModel?.go(to: .details(imdb: imdb))
        }
    }
}

// MARK: - Functions
extension MainViewController {
    private func setUI() {
        navigationController?.isNavigationBarHidden = true
        searchTextField.addGrayBorder()
        setKeyboardUI()
    }
    
    private func setData() {
        
    }
    
    private func setDelegates() {
        searchTextField.delegate = self
        moviesCollectionView.delegate = self
        moviesCollectionView.dataSource = self
        moviesCollectionView.register(UINib(nibName: "MovieCell", bundle: nil), forCellWithReuseIdentifier: "Movie Cell")
    }
    
    private func setKeyboardUI() {
        searchTextField.attributedPlaceholder = NSAttributedString(string: "Enter your search keyword", attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray6])
    }
}

// MARK: - Network
extension MainViewController: MainViewModelDelegate {
    func viewModelOutput(output: MainViewModelOutput) {
        DispatchQueue.main.async {
            self.hideLoading()
            
            switch output {
            case .noAlert:
                self.movies = nil
                self.moviesCollectionView.reloadData()
            case .showAlert(let error):
                self.movies = nil
                self.moviesCollectionView.reloadData()
                self.alert(message: error)
            case .movies(let movies):
                self.movies = movies
                self.moviesCollectionView.reloadData()
            case .addMovies(let movies):
                self.movies?.append(contentsOf: movies)
                self.moviesCollectionView.reloadData()
            }
        }
    }
    
    func navigate(to route: MainViewRoute) {
        DispatchQueue.main.async {
            switch route {
            case .details(let imdb):
                self.show(DetailsBuilder.make(imdb: imdb), sender: nil)
            }
        }
    }
}
