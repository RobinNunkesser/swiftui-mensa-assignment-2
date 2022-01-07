//
//  MensaViewModel.swift
//  Mensa
//
//  Created by Prof. Dr. Nunkesser, Robin on 07.01.22.
//

import Foundation

class MensaViewModel : ObservableObject {
    @Published var categories : [CategoryViewModel] = []
}
