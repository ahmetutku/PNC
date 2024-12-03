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
            TextField("Search for books...", text: $searchQuery)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .onChange(of: searchQuery) { _ in
                    performSearch() // Perform search whenever the search query changes
                }

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
            loadBooks()
        }
        .navigationTitle("Search")
    }

    private func loadBooks() {
        let filePath = "/Users/ahmethamamcioglu/Desktop/pnc_overview/pnc/pnc/bookData/generalInfo.json"
        let url = URL(fileURLWithPath: filePath)
        
        guard FileManager.default.fileExists(atPath: filePath) else {
            print("Error: JSON file not found at specified path: \(filePath)")
            books = []
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decodedBooks = try JSONDecoder().decode([Book].self, from: data)
            books = decodedBooks
            searchResults = books // Initially set search results to all books
        } catch {
            print("Error loading or decoding JSON: \(error)")
            books = []
        }
    }

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
