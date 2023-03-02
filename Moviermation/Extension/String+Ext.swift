//
//  String+Ext.swift
//  Moviermation
//
//  Created by Muhammed Emin Bardakcı on 2.03.2023.
//

import Foundation


extension String {
    
    func addPointsToNumber() -> String {
        var array: [String] = []
        for word in self {
            array.append(String(word))
        }
        array = array.reversed()
        
        for num in 0..<array.count {
            if num % 3 == 2 {
                array[num] = "." + array[num]
            }
        }
        
        let lastItem = array.last
        for item in lastItem! {
            if item == "." {
                array.removeLast()
            }
        }
        
        array = array.reversed()
        return array.joined()
    }
}
