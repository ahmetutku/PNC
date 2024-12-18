//
//  QuotesViewModel.swift
//  pnc
//
//  Created by Ahmet Hamamcioglu on 9.12.2024.
//

import SwiftUI

class QuotesViewModel: ObservableObject {
    @Published var quotes: [Quote] = []
    @Published var favoriteQuotes: [Quote] = []

    /// Load quotes from a list of books, ensuring no duplicates are added.
    func loadQuotes(for books: [Book]) {
        let newQuotes = books.flatMap { book in
            book.quotes.map { quoteText in
                Quote(text: quoteText, author: book.author)
            }
        }
        
        // Filter out duplicates
        let uniqueQuotes = newQuotes.filter { newQuote in
            !quotes.contains(where: { $0.text == newQuote.text && $0.author == newQuote.author })
        }
        
        quotes.append(contentsOf: uniqueQuotes)
    }

    /// Toggle a quote's favorite status
    func toggleFavorite(_ quote: Quote) {
        if let index = favoriteQuotes.firstIndex(of: quote) {
            favoriteQuotes.remove(at: index)
        } else {
            favoriteQuotes.append(quote)
        }
    }
}


