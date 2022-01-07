//
//  ContentView.swift
//  Mensa
//
//  Created by Prof. Dr. Nunkesser, Robin on 06.01.22.
//

import SwiftUI
import MockMealAdapters
import MealPorts

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
                        try success(meals: await MockGetMealsCommand().execute(inDTO: MealQueryDTO(mensa: 1, date: Date())))
                    } catch let error {
                        failure(error: error)
                    }
                }
            }
    }
    
    func success(meals: [MealCollection]) {
        viewModel.categories = meals.map({
            collection in
            CategoryViewModel(name: collection.name, meals: collection.meals.map({
                meal in
                MealViewModel(title: meal.name, subtitle: "\(meal.price.employees!)", image: URL(string: meal.image)!)
                
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
