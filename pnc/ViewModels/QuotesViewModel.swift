//
//  QuotesViewModel.swift
//  pnc
//
//  Created by Ahmet Hamamcioglu on 9.12.2024.
//

import SwiftUI

class QuotesViewModel: ObservableObject {
    @Published var quotes: [Quote] = Quote.sampleQuotes // Sample quotes for display
    @Published var favoriteQuotes: [Quote] = [] // Saved favorite quotes

    func toggleFavorite(_ quote: Quote) {
        if favoriteQuotes.contains(quote) {
            favoriteQuotes.removeAll { $0.id == quote.id }
        } else {
            favoriteQuotes.append(quote)
        }
    }
}
