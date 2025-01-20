//
//  QuoteView.swift
//  pnc
//
//  Created by Ahmet Hamamcioglu on 7.12.2024.
//
 
import SwiftUI

struct QuoteView: View {
    let quote: Quote
    @ObservedObject var quotesViewModel: QuotesViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            // Quote text
            Text("\"\(quote.text)\"")
                .font(.body)
                .multilineTextAlignment(.leading)
                .foregroundColor(.primary)

            Text("- \(quote.author)")
                .font(.subheadline)
                .foregroundColor(.secondary)

            HStack {
                Spacer()
                Button(action: {
                    quotesViewModel.toggleFavorite(quote)
                }) {
                    Image(systemName: quotesViewModel.favoriteQuotes.contains(quote) ? "star.fill" : "star")
                        .foregroundColor(quotesViewModel.favoriteQuotes.contains(quote) ? .yellow : .gray)
                        
                }
            }
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
        .shadow(radius: 2)
        .padding(.vertical, 4)
    }
}
