//
//  TitleAndLabelRowView.swift
//  Moviermation
//
//  Created by Muhammed Emin Bardakcı on 1.03.2023.
//

import UIKit

class TitleAndLabelRowView: UIView {

    let stackView = UIStackView()
    let title1 = MovTitleLabel()
    let text = MovTextLabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureStackView()
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(title: String, text: String) {
        self.init(frame: .zero)
        
        self.title1.text = title + ": "
        self.text.text = text
    }
    
    private func configureStackView() {
        backgroundColor = UIColor.viewBackgroundColor
        stackView.axis          = .horizontal
        stackView.alignment = .leading
        stackView.alignment = .bottom
        stackView.distribution  = .fill
        stackView.spacing = 3
        
        stackView.addArrangedSubview(title1)
        stackView.addArrangedSubview(text)
    }
    
    private func configure() {
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        translatesAutoresizingMaskIntoConstraints = false
    }
}
