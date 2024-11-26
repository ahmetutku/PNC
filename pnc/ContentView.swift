//
//  ContentView.swift
//  pnc
//
//  Created by Ahmet Hamamcioglu on 2.11.2024.
//

import SwiftUI

import SwiftUI

struct ContentView: View {
    @State private var quotes: [Quote] = Quote.sampleQuotes // Sample quotes for display
    @State private var isMenuOpen: Bool = false // Toggle for dropdown menu
    @State private var favoriteQuotes: [Quote] = [] // Saved favorite quotes

    var body: some View {
        NavigationView {
            ZStack {
                Color("beigeColor") // Add this color to assets for beige background
                    .ignoresSafeArea()

                VStack(spacing: 20) {
                    // App Title
                    Text("PNC")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.accentColor)
                        .padding(.top)

                    // Scrollable Quotes List
                    ScrollView {
                        ForEach(quotes) { quote in
                            QuoteRowView(quote: quote, isFavorite: favoriteQuotes.contains(quote)) {
                                toggleFavorite(quote)
                            }
                            .padding()
                        }
                    }

                    Spacer()
                }
                .padding()
                
                // Dropdown menu
                if isMenuOpen {
                    DropdownMenuView(isMenuOpen: $isMenuOpen, favoriteQuotes: $favoriteQuotes)
                }
            }
            .navigationBarItems(leading: menuButton)
            .navigationBarTitleDisplayMode(.inline)
        }
    }

    // Button for the dropdown menu
    private var menuButton: some View {
        Button(action: {
            withAnimation {
                isMenuOpen.toggle()
            }
        }) {
            Image(systemName: "line.horizontal.3")
                .imageScale(.large)
                .foregroundColor(.accentColor)
        }
    }

    // Function to toggle favorite status
    private func toggleFavorite(_ quote: Quote) {
        if favoriteQuotes.contains(quote) {
            favoriteQuotes.removeAll { $0.id == quote.id }
        } else {
            favoriteQuotes.append(quote)
        }
    }
}

// MARK: - Dropdown Menu View
struct DropdownMenuView: View {
    @Binding var isMenuOpen: Bool
    @Binding var favoriteQuotes: [Quote]

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Spacer()
                Button(action: { isMenuOpen = false }) {
                    Image(systemName: "xmark")
                        .foregroundColor(.gray)
                        .padding(.trailing)
                }
            }
            .padding(.top)

            VStack(alignment: .leading, spacing: 10) {
                menuItem(icon: "magnifyingglass", title: "Search")
                menuItem(icon: "book", title: "Books")
                NavigationLink(destination: FavoritesView(favoriteQuotes: favoriteQuotes)) {
                    menuItem(icon: "star.fill", title: "Favorites")
                }
                menuItem(icon: "flame", title: "Popular")
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
            .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .background(Color.black.opacity(0.25).edgesIgnoringSafeArea(.all))
    }

    private func menuItem(icon: String, title: String) -> some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.accentColor)
            Text(title)
                .foregroundColor(.primary)
        }
        .padding(.vertical, 5)
    }
}

// MARK: - Favorites View
struct FavoritesView: View {
    var favoriteQuotes: [Quote]

    var body: some View {
        VStack(spacing: 20) {
            Text("Favorite Quotes")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top)

            ScrollView {
                ForEach(favoriteQuotes) { quote in
                    QuoteRowView(quote: quote, isFavorite: true, toggleFavorite: {})
                        .padding()
                }
            }

            Spacer()
        }
        .padding()
        .background(Color("beigeColor").ignoresSafeArea())
    }
}

// MARK: - Quote Model and QuoteRowView remain unchanged


// MARK: - Quote Model and Sample Data
struct Quote: Identifiable, Equatable {
    let id = UUID()
    let text: String
    let author: String

    static let sampleQuotes: [Quote] = [
        Quote(text: "The only limit to our realization of tomorrow is our doubts of today.", author: "Franklin D. Roosevelt"),
        Quote(text: "Success is not final, failure is not fatal: It is the courage to continue that counts.", author: "Winston Churchill"),
        Quote(text: "Do not wait to strike till the iron is hot; but make it hot by striking.", author: "William Butler Yeats")
        // Add more quotes if needed
    ]
}

// MARK: - Quote Row View
struct QuoteRowView: View {
    var quote: Quote
    var isFavorite: Bool
    var toggleFavorite: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("\"\(quote.text)\"")
                .font(.title3)
                .multilineTextAlignment(.leading)
                .foregroundColor(.primary)

            Text("- \(quote.author)")
                .font(.subheadline)
                .foregroundColor(.secondary)

            HStack {
                Spacer()
                Button(action: toggleFavorite) {
                    Image(systemName: isFavorite ? "star.fill" : "star")
                        .foregroundColor(isFavorite ? .yellow : .gray)
                }
            }
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
        .shadow(radius: 2)
    }
}

// MARK: - Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
