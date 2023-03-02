//
//  MovTextField.swift
//  Moviermation
//
//  Created by Muhammed Emin Bardakcı on 1.03.2023.
//

import UIKit

class MovTextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        
        backgroundColor = .black
        layer.cornerRadius = 10
        layer.borderWidth = 1
        layer.borderColor = CGColor(gray: 0.5, alpha: 1)
        
        attributedPlaceholder = NSAttributedString(
            string: "Enter a movie name",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(rgb: 0x404258)]
        )
        
        textAlignment = .center
        font = UIFont.preferredFont(forTextStyle: .title3)
        textColor = UIColor.white
        tintColor = UIColor.white
        adjustsFontSizeToFitWidth = true
        minimumFontSize = 12
        
        autocorrectionType = .no
        clearButtonMode = .always
        returnKeyType = .search
    }
}
