//
//  FavoritesView.swift
//  pnc
//
//  Created by Ahmet Hamamcioglu on 9.12.2024.
//

import SwiftUI

struct FavoritesView: View {
    @ObservedObject var viewModel: QuotesViewModel

    var body: some View {
        ZStack{
            Color("background_color")
            VStack {
                Spacer()
                if(viewModel.favoriteQuotes.count == 0){
                    Spacer()
                    //able to add the same quote twice fix it
                    Text("No Favorites available")
                        .foregroundColor(Color(.subtitle))
                        .fontWeight(.bold)
                    Spacer()
                }
                else{
                    ScrollView {
                        ForEach(viewModel.favoriteQuotes) { quote in
                            QuoteRowView(quote: quote, isFavorite: true) {
                                viewModel.toggleFavorite(quote)
                            }
                            .padding()
                        }
                    }}
                
                Spacer()
            }}
        .padding()
        .background(Color("background_color").ignoresSafeArea())
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Favorite Quotes")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.accentColor)
            }
        }
    }
    
}
