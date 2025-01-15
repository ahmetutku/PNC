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
        VStack(spacing: 20) {
            Text("My Books")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top)

            if bookRowModel.favoriteBooks.isEmpty {
                Spacer() // Push the empty state message to the center
                Text("Favorited Books is Empty")
                    .multilineTextAlignment(.center)
                Spacer(minLength: 350)// Push it back up
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
        }
        .onAppear {
            books = BookLoader.loadBooks()
            print(books.count)
        }
        .padding()
        .background(Color("beigeColor").ignoresSafeArea())

    }
}

struct BookView_Previews: PreviewProvider {
    static var previews: some View {
        // Create mock books
        
        // Create a mock BookRowModel with favorite books
        let mockBookRowModel = BookRowModel()
        mockBookRowModel.favoriteBooks = []
        
        return NavigationView {
            BooksView(bookRowModel: mockBookRowModel)
        }
    }
}
