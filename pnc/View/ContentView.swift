//
//  ContentView.swift
//  pnc
//
//  Created by Ahmet Hamamcioglu on 2.11.2024.
//
import SwiftUI

// MARK: - ContentView
struct ContentView: View {
    @StateObject private var viewModel = QuotesViewModel() // Shared ViewModel
    @State private var isMenuOpen: Bool = false // Toggle for dropdown menu

    var body: some View {
        NavigationView {
            ZStack {
                Color("beigeColor") // Add this color to assets for beige background
                    .ignoresSafeArea()

                VStack(spacing: 1) {
                    ScrollView {
                    // App Title
                    Text("PNC")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.accentColor)
                        .padding(.top)

                    // Scrollable Quotes List
                    
                        ForEach(viewModel.quotes) { quote in
                            QuoteRowView(
                                quote: quote,
                                isFavorite: viewModel.favoriteQuotes.contains(quote)
                            ) {
                                viewModel.toggleFavorite(quote)
                            }
                            .padding()
                        }
                    }

                    Spacer()
                }
                .padding()
                
                // Dropdown menu
                if isMenuOpen {
                    DropdownMenuView(
                        isMenuOpen: $isMenuOpen,
                        viewModel: viewModel
                    )
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
}


// MARK: - Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
