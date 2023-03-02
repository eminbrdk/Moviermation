//
//  MovieCell.swift
//  Moviermation
//
//  Created by Muhammed Emin Bardakcı on 1.03.2023.
//

import UIKit

class MovieCell: UICollectionViewCell {
    
    static let reuseID = "MovieCell"
    let image = MovImageView(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        addSubview(image)
        
        let padding: CGFloat = 6
        let posterProportion: CGFloat = CGFloat(Float(273) / Float(184))
        
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            image.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            image.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            image.heightAnchor.constraint(equalTo: image.widthAnchor, multiplier: posterProportion)
        ])
    }
}
