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
        ZStack {
            Color("beigeColor") // Add this color to assets for beige background
                .ignoresSafeArea()
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
                    List {
                        ForEach(searchResults) { book in
                            BookRowView(book: book)
                                .listRowInsets(EdgeInsets())
                                .background(Color.white) // Set white background for book cards
                                .cornerRadius(8)
                                .shadow(color: .gray.opacity(0.2), radius: 4, x: 0, y: 2)
                                .padding(.horizontal)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                    .listStyle(PlainListStyle()) // Remove default background color of List
                }
            }
            .onAppear {
                loadBooks()
            }
        }
        .navigationTitle("Search")
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .background(Color.white.edgesIgnoringSafeArea(.all))
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
