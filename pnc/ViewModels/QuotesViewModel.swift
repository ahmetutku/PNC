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

    func loadQuotes(for books: [Book]) {
        var newQuotes:  [Quote] = []
        if(books.count != 0){
             newQuotes = books.flatMap { book in
                book.quotes.map { quoteText in
                    Quote(text: quoteText, author: book.author)
                }
            }
        }
        quotes = newQuotes
    }

    func toggleFavorite(_ quote: Quote) {
        
        if let index = favoriteQuotes.firstIndex(of: quote) {
            favoriteQuotes.remove(at: index)
        } else {
            favoriteQuotes.append(quote)
        }
        print(favoriteQuotes.count)
        print(favoriteQuotes)

    }
}


