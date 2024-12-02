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

    var body: some View {
        VStack {
            // Search Bar
            TextField("Search for books...", text: $searchQuery, onCommit: performSearch)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            // Results List
            if searchResults.isEmpty {
                Text("No results found")
                    .foregroundColor(.secondary)
                    .padding()
            } else {
                List(searchResults) { book in
                    BookRowView(book: book)
                }
            }

            Spacer()
        }
        .padding()
        .onAppear {
            loadBooks() // Load books on appear
        }
        .navigationTitle("Search")
    }

    // Load books from JSON file
    private func loadBooks() {
        guard let url = Bundle.main.url(forResource: "bookData/generalInfo", withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let decodedBooks = try? JSONDecoder().decode([Book].self, from: data) else {
            books = []
            return
        }
        books = decodedBooks
        searchResults = books // Show all books initially
    }

    // Filter books based on the search query
    private func performSearch() {
        if searchQuery.isEmpty {
            searchResults = books
        } else {
            searchResults = books.filter {
                $0.title.localizedCaseInsensitiveContains(searchQuery) ||
                $0.author.localizedCaseInsensitiveContains(searchQuery)
            }
        }
    }
}
