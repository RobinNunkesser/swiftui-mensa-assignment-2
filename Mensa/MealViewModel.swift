//
//  MealViewModel.swift
//  Mensa
//
//  Created by Prof. Dr. Nunkesser, Robin on 07.01.22.
//

import Foundation

class MealViewModel {
    let title : String
    let subtitle : String
    let image: URL
    
    init(title : String, subtitle : String, image: URL) {
        self.title = title
        self.subtitle = subtitle
        self.image = image
    }
}
