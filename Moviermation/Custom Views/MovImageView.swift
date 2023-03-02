//
//  MovImageView.swift
//  Moviermation
//
//  Created by Muhammed Emin Bardakcı on 1.03.2023.
//

import UIKit

class MovImageView: UIImageView {
    
    let placeholderImage = UIImage(named: "movie")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(imageLink: String) {
        Task { self.image = await NetworkManager.shared.downloadImage(imageLink: imageLink) ?? placeholderImage }
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        
        clipsToBounds = true
        layer.cornerRadius = 6
    }
}
