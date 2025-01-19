//
//  QuoteRowView.swift
//  pnc
//
//  Created by Ahmet Hamamcioglu on 7.12.2024.
//
import SwiftUI

struct QuoteRowView: View {
    var quote: Quote
    var isFavorite: Bool
    var toggleFavorite: () -> Void

    var body: some View {
        
        VStack(alignment: .leading, spacing: 10) {
            Text("\"\(quote.text)\"")
                .font(.title3)
                .multilineTextAlignment(.leading)
                .foregroundColor(.primary)

            Text("- \(quote.author)")
                .font(.subheadline)
                .foregroundColor(.secondary)

            HStack {
                Spacer()
                Button(action: toggleFavorite) {
                    Image(systemName: isFavorite ? "star.fill" : "star")
                        .foregroundColor(isFavorite ? .yellow : .gray)
                }
            }
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 10).fill(Color("background_color")))
        .shadow(color: Color("bookShadow_color").opacity(0.33),radius: 2)
    }
}
