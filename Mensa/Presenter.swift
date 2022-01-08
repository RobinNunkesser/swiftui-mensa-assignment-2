//
//  Presenter.swift
//  Mensa
//
//  Created by Prof. Dr. Nunkesser, Robin on 08.01.22.
//

import Foundation
import MealPorts

let euroFormatter: NumberFormatter = {
    let formatter = NumberFormatter()
    formatter.numberStyle = .currency
    formatter.currencyCode = "EUR"
    return formatter
}()
    
extension MealCollection {
    func toCategoryViewModel(status: Int) -> CategoryViewModel {
        var name = "Hauptgericht"
        switch category {
        case .dessert: name = "Desserts"
        case .none: name = ""
        case .dish: name = "Hauptgerichte"
        case .sidedish: name = "Beilagen"
        case .soup: name = "Suppen / Eintöpfe"
        }
        return CategoryViewModel(name: name, meals: meals.map({$0.toMealViewModel(status: status)}))
    }
}

extension Meal {
    func toMealViewModel(status: Int) -> MealViewModel {
        var concretePrice : Double?
        switch status {
        case 0: concretePrice = price.students
        case 1: concretePrice = price.employees
        case 2: concretePrice = price.pupils
        case 3: concretePrice = price.others
        default: break
        }
        var priceString = "-"
        if let concretePrice = concretePrice {
            priceString = euroFormatter.string(from: NSNumber(floatLiteral: concretePrice))!
        }        
        let image = URL(string: image) ?? URL(string: "https://images.unsplash.com/photo-1546069901-ba9599a7e63c?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=100&q=80")!
        return MealViewModel(title: name, subtitle: priceString, image: image)                
    }
}
