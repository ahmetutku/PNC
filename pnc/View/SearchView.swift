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
    @ObservedObject var bookRowModel: BookRowModel // Changed from 'model' to 'bookRowModel'

    var body: some View {
        ZStack {
            Color("beigeColor") // Add this color to assets for beige background
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
                                BookRowView(book: book, model: bookRowModel) // Pass the model here
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
        .background(Color.white.edgesIgnoringSafeArea(.all))
    }

}
