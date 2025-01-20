//
//  FavoritesView.swift
//  pnc
//
//  Created by Ahmet Hamamcioglu on 9.12.2024.
//

import SwiftUI

struct FavoritesView: View {
    @ObservedObject var quotesViewModel: QuotesViewModel

    var body: some View {
        ZStack{
            Color("background_color")
            VStack {
                Spacer()
                if(quotesViewModel.favoriteQuotes.count == 0){
                    Spacer()
                    //able to add the same quote twice fix it
                    Text("No Favorites available")
                        .foregroundColor(Color(.subtitle))
                        .fontWeight(.bold)
                    Spacer()
                }
                else{
                    ScrollView {
                        ForEach(quotesViewModel.favoriteQuotes) { quote in
                            QuoteRowView(quote: quote,                                    quotesViewModel: quotesViewModel, isFavorite: true) {
                                quotesViewModel.toggleFavorite(quote)
                            }
                            .padding()
                        }
                    }}
                
                Spacer()
            }}
        .padding()
        .padding(.top, -20.0)
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
