import SwiftUI

struct ContentView: View {
    @StateObject var quotesViewModel = QuotesViewModel()
    @StateObject var bookRowModel = BookRowModel()
    @State private var isMenuOpen: Bool = false
    @State private var menuPosition: CGPoint = .zero

    var body: some View {
        NavigationView {
            ZStack(alignment: .topLeading) {
                Color("beigeColor").ignoresSafeArea()

                VStack(spacing: 1) {
                    ScrollView {
                        // App Title
                        Text("PNC")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.accentColor)
                            .padding(.top)

                        // Display quotes from selected books
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
                    ).padding(.top, -60.0)
                }
            }
            .navigationBarItems(leading: menuButton)
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                quotesViewModel.loadQuotes(for: bookRowModel.favoriteBooks)
            }
        }
    }

    private var menuButton: some View {
        GeometryReader { geometry in
            Button(action: {
                withAnimation {
                    isMenuOpen.toggle()
                    menuPosition = CGPoint(
                        x: geometry.frame(in: .global).minX + 20,
                        y: geometry.frame(in: .global).maxY + 10
                    )
                }
            }) {
                Image(systemName: "line.horizontal.3")
                    .imageScale(.large)
                    .foregroundColor(.accentColor)
            }
        }
        .frame(width: 44, height: 44)
    }
}

// MARK: - Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

