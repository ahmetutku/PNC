//
//  FavoritesView.swift
//  pnc
//
//  Created by Ahmet Hamamcioglu on 9.12.2024.
//

import SwiftUI

// MARK: - Favorites View
struct FavoritesView: View {
    @ObservedObject var viewModel: QuotesViewModel

    var body: some View {
        VStack(spacing: 20) {
            Text("Favorite Quotes")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top)

            ScrollView {
                ForEach(viewModel.favoriteQuotes) { quote in
                    QuoteRowView(quote: quote, isFavorite: true) {
                        viewModel.toggleFavorite(quote)
                    }
                    .padding()
                }
            }

            Spacer()
        }
        .padding()
        .background(Color("beigeColor").ignoresSafeArea())
    }
}
