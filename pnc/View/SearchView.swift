//
//  SearchView.swift
//  pnc
//
//  Created by Ahmet Hamamcioglu on 1.12.2024.
//


import SwiftUI

struct SearchView: View {
    @State private var searchQuery = ""
    @State private var searchResults: [Book] = []
    @State private var books: [Book] = []
    @ObservedObject var bookRowModel: BookRowModel 

    var body: some View {
        ZStack {
            Color("background_color")
                .ignoresSafeArea()
            VStack {
                TextField("Search for books...", text: $searchQuery)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .onChange(of: searchQuery) { _ in
                        searchResults = BookLoader.performSearch(books: books, query: searchQuery)
                    }

                if searchResults.isEmpty {
                    Spacer()
                    Text("No results found")
                    Spacer()
                } else {
                    List {
                        ForEach(searchResults) { book in
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
                searchResults = books
    
            }
        }
        .navigationTitle("Search")
        .navigationBarTitleDisplayMode(.inline)
        .background(Color.white.edgesIgnoringSafeArea(.all))
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        let searchBookRowModel = BookRowModel()
        searchBookRowModel.favoriteBooks = []

        return Group {
            NavigationView {
                SearchView(bookRowModel: searchBookRowModel)
            }
        }
    }
}
