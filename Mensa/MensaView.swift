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
    @EnvironmentObject var appEnvironment : AppEnvironment
    @StateObject var viewModel = MensaViewModel()
    @State private var showError = false
    @State private var errorText = ""
    
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
                        success(meals: meals)
                    } catch let error {
                        failure(error: error)
                    }
                }
            }
            .onChange(of: appEnvironment.status) { newValue in
                setCategories()
            }
            .alert(isPresented: $showError) { () -> Alert in
                Alert(title: Text("Error"), message: Text(errorText),
                      dismissButton: .cancel(Text("OK")))
            }
    }
    
    func success(meals: [MealCollection]) {
        viewModel.originalMeals = meals
        setCategories()
    }
    
    func setCategories() {
        viewModel.categories = viewModel.originalMeals.map({$0.toCategoryViewModel(status: appEnvironment.status)})
    }
    
    func failure(error: Error) {
        errorText = error.localizedDescription
        showError.toggle()
    }
}

struct MensaView_Previews: PreviewProvider {
    static var previews: some View {
        MensaView()
    }
}
