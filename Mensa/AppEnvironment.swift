//
//  AppEnvironment.swift
//  Mensa
//
//  Created by Prof. Dr. Nunkesser, Robin on 08.01.22.
//

import Foundation

class AppEnvironment : ObservableObject, Equatable {
    @Published var status = 0
    
    static func == (lhs: AppEnvironment, rhs: AppEnvironment) -> Bool {
        return lhs.status == rhs.status
    }

}
