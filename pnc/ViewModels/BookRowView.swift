//
//  BookRowView.swift
//  pnc
//
//  Created by Ahmet Hamamcioglu on 1.12.2024.
//


import SwiftUI


struct BookRowView: View {
    let book: Book

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(book.title)
                .font(.headline)
                .foregroundColor(.primary)

            Text(book.author)
                .font(.subheadline)
                .foregroundColor(.secondary)

            Text("\(book.year)")
                .font(.caption)
                .foregroundColor(.secondary)

            Text(book.description)
                .font(.body)
                .foregroundColor(.primary)
                .lineLimit(3)
        }
//        .padding()
//        .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
//        .shadow(radius: 2)
    }
}
