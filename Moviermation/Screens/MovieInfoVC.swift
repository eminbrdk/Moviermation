//
//  MovieInfoVC.swift
//  Moviermation
//
//  Created by Muhammed Emin Bardakcı on 1.03.2023.
//

import UIKit

class MovieInfoVC: UIViewController {

    var movieInfo: MovieInfo!
    var movieID: Int!
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    
    var poster = MovImageView(frame: .zero)
    var overView = MovTextLabel()
    
    let genreView = UIView()
    let genreTitle = MovTitleLabel()
    let genres = MovTextLabel()
    
    var voteView: TitleAndLabelRowView!
    var dateView: TitleAndLabelRowView!
    var budgetView: TitleAndLabelRowView!
    var revenueView: TitleAndLabelRowView!
    
    var OptionalViews: [UIView] = []
    
    let padding: CGFloat = 12
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getMovieInfo()
        configureVC()
    }
    
    func configureVC() {
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = UIColor.viewBackgroundColor
    }
    
// MARK: - Take data from api
    
    func getMovieInfo() {
        Task {
            movieInfo = await NetworkManager.shared.getMovieInfo(id: movieID)
            
            title = movieInfo.original_title ?? "nil"
            poster.set(imageLink: movieInfo.poster_path ?? "nil")
            
            getAndSetOverview()
            getAndSetGenres()
            getAndSetVote()
            getAndSetBudget()
            getAndSetRevenue()
            
            configure()
        }
    }
    
// MARK: - If data is not optional, add and set to the view
    
    func getAndSetOverview() {
        if let overview = movieInfo.overview, overview != "" {
            OptionalViews.append(overView)
            overView.text = overview
            
            NSLayoutConstraint.activate([
                overView.heightAnchor.constraint(equalToConstant: 90)
            ])
        }
    }
    
    func getAndSetGenres() {
        if let genreNames = movieInfo.genres {
            genreTitle.text = "Genres"
            
            var genreText = ""
            for genre in genreNames {
                if let name = genre.name {
                    genreText = genreText + name + ", "
                }
            }
            if genreText != "" {
                genreText.removeLast()
                genreText.removeLast()
                
                genreView.addSubview(genreTitle)
                genreView.addSubview(genres)
                genreView.translatesAutoresizingMaskIntoConstraints = false
                OptionalViews.append(genreView)
                
                NSLayoutConstraint.activate([
                    genreView.heightAnchor.constraint(equalToConstant: 60),
                    
                    genreTitle.topAnchor.constraint(equalTo: genreView.topAnchor),
                    genreTitle.leadingAnchor.constraint(equalTo: genreView.leadingAnchor),
                    genreTitle.trailingAnchor.constraint(equalTo: genreView.trailingAnchor),
                    genreTitle.heightAnchor.constraint(equalToConstant: 30),
                    
                    genres.topAnchor.constraint(equalTo: genreTitle.bottomAnchor, constant: 3),
                    genres.leadingAnchor.constraint(equalTo: genreView.leadingAnchor),
                    genres.trailingAnchor.constraint(equalTo: genreView.trailingAnchor),
                    genres.bottomAnchor.constraint(equalTo: genreView.bottomAnchor)
                    
                ])
            }
            self.genres.text = genreText
        }
    }
    
    func getAndSetVote() {
        if let vote = movieInfo.vote_average, vote != 0.0 {
            voteView = TitleAndLabelRowView(title: "Vote", text: String(vote))
            OptionalViews.append(voteView)
            
            NSLayoutConstraint.activate([
                voteView.heightAnchor.constraint(equalToConstant: 40)
            ])
        }
    }
    
    func getAndSetBudget() {
        if let budget = movieInfo.budget, budget != 0 {
            budgetView = TitleAndLabelRowView(title: "Budget", text: String(budget).addPointsToNumber())
            OptionalViews.append(budgetView)
            
            NSLayoutConstraint.activate([
                budgetView.heightAnchor.constraint(equalToConstant: 40)
            ])
        }
    }
    
    func getAndSetRevenue() {
        if let revenue = movieInfo.revenue, revenue != 0 {
            revenueView = TitleAndLabelRowView(title: "Revenue", text: String(revenue).addPointsToNumber())
            OptionalViews.append(revenueView)
            
            NSLayoutConstraint.activate([
                revenueView.heightAnchor.constraint(equalToConstant: 40)
            ])
        }
    }
    
// MARK: - Configure View
    
    func configure() {
        configureScrollView()
        configureOptionals()
        configurePoster()
    }
    
    func configureScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        scrollView.pinToEdges(of: view)
        contentView.pinToEdges(of: scrollView)
        
        contentView.addSubview(poster)
        for item in OptionalViews {
            contentView.addSubview(item)
        }
        
        NSLayoutConstraint.activate([
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
        ])
    }
    
    func configurePoster() {
        let posterProportion: CGFloat = CGFloat(Float(273) / Float(184))
        
        NSLayoutConstraint.activate([
            poster.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: padding),
            poster.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            poster.widthAnchor.constraint(equalToConstant: 230),
            poster.heightAnchor.constraint(equalTo: poster.widthAnchor, multiplier: posterProportion),
        ])
    }
    
    func configureOptionals() {
        if OptionalViews != [] {
            NSLayoutConstraint.activate([
                contentView.bottomAnchor.constraint(equalTo: OptionalViews.last!.bottomAnchor)
            ])
        }
        
        for viewNumber in 0..<OptionalViews.count {
            NSLayoutConstraint.activate([
                OptionalViews[viewNumber].leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
                OptionalViews[viewNumber].trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding)
            ])
            
            if viewNumber == 0 {
                NSLayoutConstraint.activate([
                    OptionalViews[viewNumber].topAnchor.constraint(equalTo: poster.bottomAnchor, constant: 15)
                ])
            } else {
                NSLayoutConstraint.activate([
                    OptionalViews[viewNumber].topAnchor.constraint(equalTo: OptionalViews[viewNumber - 1].bottomAnchor, constant: 15)
                ])
            }
        }
    }
}
