//
//  FavoritesView.swift
//  pnc
//
//  Created by Ahmet Hamamcioglu on 9.12.2024.
//

import SwiftUI

struct BooksView: View {
    @ObservedObject var bookRowModel: BookRowModel
    @State private var books: [Book] = []

    var body: some View {
        ZStack{
            Color("background_color")
            VStack(spacing: 20) {
                if bookRowModel.favoriteBooks.isEmpty { 
                    Spacer()
                    Text("Favorited Books is Empty")
                        .foregroundColor(Color(.subtitle))
                        .fontWeight(.bold)
                    
                    Spacer()
                } else {
                    ScrollView {
                        ForEach(bookRowModel.favoriteBooks) { book in
                            NavigationLink(destination: BookDetailView(book: book, model: bookRowModel)) {
                                BookRowView(book: book, model: bookRowModel)
                            }
                        }
                        .padding()
                    }
                    .listStyle(PlainListStyle())
                }
                Spacer()
            }}
        .onAppear {
            books = BookLoader.loadBooks()
        }
        .padding()
        .padding(.top, -10.0)
        .background(Color("background_color").ignoresSafeArea())
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("My Books")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.accentColor)
            }
        }
    }
}

struct BookView_Previews: PreviewProvider {
    static var previews: some View {
        let emptyBookRowModel = BookRowModel()
        emptyBookRowModel.favoriteBooks = []
        
        let filledBookRowModel = BookRowModel()
        filledBookRowModel.favoriteBooks = [
                    Book(
                        id: UUID(),
                        title: "The Swift Programming Language",
                        author: "Apple Inc.",
                        year: 2024,
                        description: "A comprehensive guide to Swift programming.",
                        quotes: ["Swift is fast and safe.", "Code is meant to be read."]
                    ),
                    Book(
                        id: UUID(),
                        title: "Clean Code",
                        author: "Robert C. Martin",
                        year: 2008,
                        description: "A guide to writing clean, maintainable code.",
                        quotes: ["Clean code is readable.", "Simplicity is the key to brilliance."]
                    )
                ]

        return Group {
            NavigationView {
                BooksView(bookRowModel: emptyBookRowModel)
            }
            .previewDisplayName("Empty Favorites")
            
            NavigationView {
                BooksView(bookRowModel: filledBookRowModel)
            }
            .previewDisplayName("With Favorites")
        }
    }
}
