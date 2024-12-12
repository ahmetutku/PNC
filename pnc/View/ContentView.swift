import SwiftUI

// MARK: - ContentView
struct ContentView: View {
    @StateObject var quotesViewModel = QuotesViewModel()
    @StateObject var bookRowModel = BookRowModel()
    @State private var isMenuOpen: Bool = false // Toggle for dropdown menu
    @State private var menuPosition: CGPoint = .zero // Position for the dropdown menu

    var body: some View {
        NavigationView {
            ZStack(alignment: .topLeading) {
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
                        ForEach(quotesViewModel.quotes) { quote in
                            QuoteRowView(
                                quote: quote,
                                isFavorite: quotesViewModel.favoriteQuotes.contains(quote)
                            ) {
                                quotesViewModel.toggleFavorite(quote)
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
                        quotesViewModel: quotesViewModel,
                        bookRowModel: bookRowModel
                    ).padding(.top, -60.0
                    )
                    // Position the menu under the button
                }
            }
            .navigationBarItems(leading: menuButton)
            .navigationBarTitleDisplayMode(.inline)
        }
    }

    // Button for the dropdown menu
    private var menuButton: some View {
        GeometryReader { geometry in
            Button(action: {
                withAnimation {
                    isMenuOpen.toggle()
                    // Capture the button's position
                    menuPosition = CGPoint(
                        x: geometry.frame(in: .global).minX + 20, // Adjust horizontal offset
                        y: geometry.frame(in: .global).maxY + 10  // Place the dropdown below the button
                    )
                }
            }) {
                Image(systemName: "line.horizontal.3")
                    .imageScale(.large)
                    .foregroundColor(.accentColor)
            }
        }
        .frame(width: 44, height: 44) // Ensure the button has a consistent size
    }
}

// MARK: - Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
