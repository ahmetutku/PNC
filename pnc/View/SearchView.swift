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
                        performSearch()
                    }

                if searchResults.isEmpty {
                    Spacer()
                    Text("No results found")
                    Spacer()
                } else {
                    List {
                        ForEach(searchResults) { book in
                            NavigationLink(destination: BookDetailView(book: book)) {
                                BookRowView(book: book, model: bookRowModel) // Pass the model here
                            }
                        }
                        .padding()
                    }
                    .listStyle(PlainListStyle())
                }
            }
            .onAppear {
                loadBooks()
            }
        }
        .navigationTitle("Search")
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
            searchResults = books
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
