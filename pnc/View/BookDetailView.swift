//
//  BookDetailView.swift
//  pnc
//
//  Created by Ahmet Hamamcioglu on 3.12.2024.
//

import SwiftUI

struct BookDetailView: View {
    let book: Book
    @ObservedObject var model: BookRowModel

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Book description
                Text(book.description)
                    .font(.body)
                    .padding(.bottom)

                // Quotes section
                if !book.quotes.isEmpty {
                    Text("Quotes")
                        .font(.title2)
                        .bold()
                        .padding(.bottom, 8)

                    ForEach(book.quotes, id: \.self) { quote in
                        VStack(alignment: .leading, spacing: 8) {
                            Text("“")
                                .font(.system(size: 40))
                                .foregroundColor(.blue)
                                .padding(.bottom, -30)
                                .padding(.leading, 5)
                            
                            Text(quote)
                                .font(.body)
                                .italic()
                                .padding(.leading)
                                .padding(.trailing)
                                .lineSpacing(4)

                            Text("”")
                                .font(.system(size: 40))
                                .foregroundColor(.blue)
                                .padding(.top, -20)
                                .padding(.leading, 5)
                        }
                        .padding(.vertical, 12)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(10)
                        .padding(.horizontal, 4)
                    }
                } else {
                    Text("No quotes available for this book.")
                        .italic()
                        .foregroundColor(.gray)
                }
                Spacer()
                Button(action: {
                    model.addToMyBooks(book)
                }) {
                    Text(model.favoriteBooks.contains(where: { $0.id == book.id }) ? "Remove" : "Add")
                        .font(.caption)
                        .foregroundColor(.white)
                        .padding(8)
                        .background(model.favoriteBooks.contains(where: { $0.id == book.id }) ? Color.red : Color.blue)
                        .cornerRadius(8)
                }
                .buttonStyle(PlainButtonStyle()) // Ensure it doesn't inherit button styles from NavigationLink
            
            }
            .padding()
        }
        .navigationTitle(book.title)
    }
}

