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
    
    // MARK: - View
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDelegates()
        
        
        let parameters = [
            "apikey": "14a22d2c",
            "s": "as"
        ]

        // All three of these calls are equivalent
        showLoading()
        AF.request(Constants.BASE_URL, parameters: parameters).responseDecodable(of: Movie.self) { response in
            let movie = response.value
            print("Title: ", movie?.Title)
            
            debugPrint(response)
            self.hideLoading()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setUI()
        setData()
    }
}

// MARK: - Delegate
extension MainViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if let text = textField.text {
            let count = text.count
            
            if count < 3 {
                searchTextField.addRedBorder()
            } else {
                searchTextField.addGreenBorder()
            }
            
            print(count, text)
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        searchTextField.addGrayBorder()
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let movieCell = moviesCollectionView.dequeueReusableCell(withReuseIdentifier: "Movie Cell", for: indexPath) as? MovieCell {
            
            return movieCell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 120)
    }
}

// MARK: - Functions
extension MainViewController {
    private func setUI() {
        searchTextField.addGrayBorder()
    }
    
    private func setData() {
        
    }
    
    private func setDelegates() {
        searchTextField.delegate = self
        moviesCollectionView.delegate = self
        moviesCollectionView.dataSource = self
        moviesCollectionView.register(UINib(nibName: "MovieCell", bundle: nil), forCellWithReuseIdentifier: "Movie Cell")
    }
}

// MARK: - Network
extension MainViewController: MainViewModelDelegate {
    func viewModelOutput(output: MainViewModelOutput) {
        DispatchQueue.main.async {
            switch output {
            case .showAlert(let response):
                print(response)
            }
        }
    }
    
    func navigate(to route: MainViewRoute) {
        DispatchQueue.main.async {
            switch route {
            case .details:
                print("go to details")
            }
        }
    }
}
