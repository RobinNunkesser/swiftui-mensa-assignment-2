//
//  MealRow.swift
//  Mensa
//
//  Created by Prof. Dr. Nunkesser, Robin on 07.01.22.
//

import SwiftUI
import URLImage

struct MealRow: View {
    var text : String
    var detailText: String
    var url: URL
    
    var body: some View {
        HStack {
            URLImage(url) { image in
                image
                    .aspectRatio(contentMode: .fit)
            }
            VStack(alignment: .leading) {
                Text(verbatim: text)
                    .font(.subheadline)
                Text(verbatim: detailText)
                    .font(.caption)
            }
        }
    }
}

struct MealRow_Previews: PreviewProvider {
    static var previews: some View {
        MealRow(text: "Some Text", detailText: "Some Detail Text", url: URL(string: "https://www.apple.com")!)
    }
}
