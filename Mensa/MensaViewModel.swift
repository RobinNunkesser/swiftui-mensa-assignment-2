//
//  MensaViewModel.swift
//  Mensa
//
//  Created by Prof. Dr. Nunkesser, Robin on 07.01.22.
//

import Foundation
import MealPorts

class MensaViewModel : ObservableObject {
    @Published var categories : [CategoryViewModel] = []
    var originalMeals : [MealCollection] = []
}
