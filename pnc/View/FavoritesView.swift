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
        VStack(spacing: 20) {
            Text("Favorite Quotes")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top)
            if(viewModel.favoriteQuotes.count == 0){
                Spacer()
                Text("No Favorites available")
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
        }
        .padding()
        .background(Color("beigeColor").ignoresSafeArea())
    }
}
