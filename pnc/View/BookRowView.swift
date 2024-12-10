//
//  BookRowView.swift
//  pnc
//
//  Created by Ahmet Hamamcioglu on 1.12.2024.
//


import SwiftUI


struct BookRowView: View {
    let book: Book
    @ObservedObject var model: BookRowModel

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

            HStack {
                Spacer()
                Button(action: {
                    model.addToMyBooks(book)
                }) {
                    Text(model.favoriteBooks.contains(where: { $0.id == book.id }) ? "Remove from My Books" : "Add to My Books")
                        .font(.caption)
                        .foregroundColor(.white)
                        .padding(8)
                        .background(model.favoriteBooks.contains(where: { $0.id == book.id }) ? Color.red : Color.blue)
                        .cornerRadius(8)
                }
            }
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
        .shadow(radius: 2)
    }
}

