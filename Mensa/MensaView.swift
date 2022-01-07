//
//  ContentView.swift
//  Mensa
//
//  Created by Prof. Dr. Nunkesser, Robin on 06.01.22.
//

import SwiftUI
import MockMealAdapters
import MealPorts
import OpenMensaMealAdapters

struct MensaView: View {
    @StateObject var viewModel = MensaViewModel()
    
    var body: some View {
        List {
            ForEach(viewModel.categories, id: \.name) { category in
                Section(header: Text(category.name)) {
                    ForEach(category.meals, id: \.title) {
                        MealRow(text: $0.title, detailText: $0.subtitle, url: $0.image)
                    }
                }
            }
        }.navigationBarTitle("Collections")
            .onAppear {
                Task(priority: .medium) {
                    do {
                        let meals = try await MockGetMealsCommand().execute(inDTO: MealQueryDTO(mensa: 42, date: Date()))
/*                        let formatter = DateFormatter()
                        formatter.dateFormat = "yyyy/MM/dd"
                        let someDateTime = formatter.date(from: "2022/01/11")!
                        let meals = try await GetOpenMensaMealsCommand().execute(inDTO: MealQueryDTO(mensa: 42, date: someDateTime))*/
                        success(meals: meals)
                    } catch let error {
                        failure(error: error)
                    }
                }
            }
    }
    
    func success(meals: [MealCollection]) {
        viewModel.categories = meals.map({
            collection in
            var name = "Hauptgericht"
            switch collection.category {
            case .dessert: name = "Desserts"
            case .none: name = ""
            case .dish: name = "Hauptgerichte"
            case .sidedish: name = "Beilagen"
            case .soup: name = "Suppen / Eintöpfe"
            }
            return CategoryViewModel(name: name, meals: collection.meals.map({
                meal in
                let price = "\(String(describing: meal.price.employees))"
                let image = URL(string: meal.image) ?? URL(string: "https://images.unsplash.com/photo-1546069901-ba9599a7e63c?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=100&q=80")!
                return MealViewModel(title: meal.name, subtitle: price, image: image)
                
            }))
            
        })        
    }
    
    func failure(error: Error) {
        debugPrint(error.localizedDescription)
    }
}

struct MensaView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
