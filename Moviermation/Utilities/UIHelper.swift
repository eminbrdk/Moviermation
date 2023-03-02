//
//  UIHelper.swift
//  Moviermation
//
//  Created by Muhammed Emin Bardakcı on 1.03.2023.
//

import UIKit

enum UIHelper {
    
    static func createTwoColumnFlowLayout(in view: UIView) -> UICollectionViewFlowLayout {
        let width                       = view.bounds.width
        let padding: CGFloat            = 12
        let minimumItemSpacing: CGFloat = 10
        let availableWidth              = width - (padding * 2) - (minimumItemSpacing * 2)
        let itemWidth                   = availableWidth / 2
        let posterProportion: CGFloat = CGFloat(Float(273) / Float(184))
        
        let flowLayout                  = UICollectionViewFlowLayout()
        flowLayout.sectionInset         = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize             = CGSize(width: itemWidth, height: itemWidth * posterProportion)
        
        return flowLayout
    }
}
