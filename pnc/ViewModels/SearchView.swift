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
        // Specify the full path to your JSON file on your desktop
        let filePath = "/Users/ahmethamamcioglu/Desktop/pnc_overview/pnc/pnc/bookData/generalInfo.json"
        
        // Convert the string path to a URL
        let url = URL(fileURLWithPath: filePath)
        
        // Check if the file exists at the specified path
        guard FileManager.default.fileExists(atPath: filePath) else {
            print("Error: JSON file not found at specified path: \(filePath)")
            books = []
            return
        }
        
        do {
            // Attempt to load the data from the file
            let data = try Data(contentsOf: url)
            
            // Attempt to decode the data into an array of Book objects
            let decodedBooks = try JSONDecoder().decode([Book].self, from: data)
            
            books = decodedBooks // Update the books array
            searchResults = books // Show all books initially
            print("Successfully loaded books: \(searchResults.map { $0.title })")
        } catch {
            // Catch and log any errors during data loading or decoding
            print("Error loading or decoding JSON: \(error)")
            books = [] // Clear books array on failure
        }
    }



    // Filter books based on the search query
    private func performSearch() {
        print("Search query: \(searchQuery)")
        if searchQuery.isEmpty {
            searchResults = books
        } else {
            searchResults = books.filter {
                $0.title.localizedCaseInsensitiveContains(searchQuery) ||
                $0.author.localizedCaseInsensitiveContains(searchQuery)
            }
        }
        print("Search results: \(searchResults.map { $0.title })")
    }
}
