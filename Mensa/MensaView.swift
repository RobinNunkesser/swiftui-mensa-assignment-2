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
                viewModel.categories.append(CategoryViewModel(name: "Test", meals: [MealViewModel(title: "T", subtitle: "S", image: URL(string: "https://www.apple.com")!)]))
                Task(priority: .medium) {
                    do {
                        try success(meals: await MockMealDataSource().retrieveAll())
                    } catch let error {
                        failure(error: error)
                    }
                }
            }
    }
    
    func success(meals: [Meal]) {
        debugPrint(meals)
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
