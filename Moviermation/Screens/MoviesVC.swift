//
//  MoviesVC.swift
//  Moviermation
//
//  Created by Muhammed Emin Bardakcı on 1.03.2023.
//

import UIKit

protocol NoMovieDelegate {
    func changeErrorLabel(text: String)
}

class MoviesVC: UIViewController {

    enum Section { case main }
    
    var moviename: String!
    var page = 1
    var movies: [Movie] = []
    var hasMoreMovie = false
    
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Movie>!
    
    var delegate: NoMovieDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureVC()
        configureCollectionView()
        configureDataSource()
        getMovies()
    }
    
    func configureVC() {
        view.backgroundColor = UIColor.viewBackgroundColor
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func configureCollectionView() {
        collectionView = UICollectionView(frame: view.frame, collectionViewLayout: UIHelper.createTwoColumnFlowLayout(in: view))
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.backgroundColor = UIColor.viewBackgroundColor
        collectionView.register(MovieCell.self, forCellWithReuseIdentifier: MovieCell.reuseID)
    }
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Movie>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, movie) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.reuseID, for: indexPath) as! MovieCell
            cell.image.set(imageLink: movie.poster_path ?? "nil")
            return cell
        })
    }
    
    func updateData(on movies: [Movie]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Movie>()
        snapshot.appendSections([.main])
        snapshot.appendItems(movies)
        DispatchQueue.main.async { self.dataSource.apply(snapshot, animatingDifferences: true) }
    }
    
    func getMovies() {
        Task {
            do {
                let movies20 = try await NetworkManager.shared.getMovies(moviename: moviename, page: page)
                
                movies.append(contentsOf: movies20)
                
                guard movies != [] else {
                    navigationController?.popToRootViewController(animated: true)
                    delegate?.changeErrorLabel(text: "We could not find a moview. Sorry :/")
                    return
                }
                
                hasMoreMovie = movies20.count == 20 ? true : false
                
                updateData(on: movies)
            } catch {
                guard let error = error as? MovError else { return }
                
                navigationController?.popToRootViewController(animated: true)
                delegate?.changeErrorLabel(text: error.rawValue)
            }
        }
    }

}


extension MoviesVC: UICollectionViewDelegate {
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY         = scrollView.contentOffset.y
        let contentHeight   = scrollView.contentSize.height
        let height          = scrollView.frame.size.height
        
        if offsetY > contentHeight - height {
            guard hasMoreMovie else { return }
            page += 1
            getMovies()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let movieID = movies[indexPath.item].id
        let destVC = MovieInfoVC()
        destVC.movieID = movieID
        
        navigationItem.backButtonTitle = ""
        navigationController?.pushViewController(destVC, animated: true)
    }
}


