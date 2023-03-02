//
//  MovButton.swift
//  Moviermation
//
//  Created by Muhammed Emin Bardakcı on 1.03.2023.
//

import UIKit

class MovButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        
        configuration = .filled()
        configuration?.title = "Search"
        
        configuration?.cornerStyle = .medium
        configuration?.baseBackgroundColor = UIColor(rgb: 0x820000)
        configuration?.baseForegroundColor = .white
    }
    
}
