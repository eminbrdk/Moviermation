//
//  SearchVC.swift
//  Moviermation
//
//  Created by Muhammed Emin Bardakcı on 1.03.2023.
//

import UIKit

class SearchVC: UIViewController {

    let iconImage = UIImageView()
    let movieTextField = MovTextField()
    let errorLabel = MovErrorLabel()
    let searchButton = MovButton()
    
    let searchBarButton = UIBarButtonItem(title: "Search", style: .done, target: .none, action: #selector(searhButtonPressed))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureCustomViews()
        createDissMissKeyboardWithTap()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configureViewController()
    }
    
    func configureViewController() {
        navigationController?.navigationBar.prefersLargeTitles = false
        view.backgroundColor = UIColor.viewBackgroundColor
        navigationItem.rightBarButtonItem = searchBarButton
    }
    
    func configureCustomViews() {
        view.addSubviews(movieTextField, searchButton, errorLabel, iconImage)
        
        iconImage.image = UIImage(named: "movie")
        iconImage.translatesAutoresizingMaskIntoConstraints = false
        movieTextField.delegate = self
        searchButton.addTarget(self, action: #selector(searhButtonPressed), for: .touchUpInside)
        
        let padding: CGFloat = 20
        
        for customViews in [movieTextField, searchButton, errorLabel] {
            NSLayoutConstraint.activate([
                customViews.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
                customViews.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding)
            ])
        }
        
        NSLayoutConstraint.activate([
            iconImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 90),
            iconImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            iconImage.heightAnchor.constraint(equalToConstant: 200),
            iconImage.widthAnchor.constraint(equalTo: iconImage.heightAnchor),
            
            movieTextField.topAnchor.constraint(equalTo: iconImage.bottomAnchor, constant: 70),
            movieTextField.heightAnchor.constraint(equalToConstant: 50),
            
            errorLabel.topAnchor.constraint(equalTo: movieTextField.bottomAnchor, constant: 20),
            errorLabel.heightAnchor.constraint(equalToConstant: 40),
            
            searchButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -90),
            searchButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc func searhButtonPressed() {
        guard let text = movieTextField.text, !text.isEmpty else {
            errorLabel.text = "Please enter a movie name"
            return
        }
        
        errorLabel.text = ""
        let moviesVC = MoviesVC()
        moviesVC.title = text
        moviesVC.moviename = text
        moviesVC.delegate = self
        navigationItem.backButtonTitle = ""
        
        navigationController?.pushViewController(moviesVC, animated: true)
    }
    
    func createDissMissKeyboardWithTap() {
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
}


extension SearchVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searhButtonPressed()
        return true
    }
}

extension SearchVC: NoMovieDelegate {
    
    func changeErrorLabel(text: String) {
        errorLabel.text = text
    }
}
