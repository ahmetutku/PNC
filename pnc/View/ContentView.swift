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
                        if(quotesViewModel.quotes.count == 0){
                            Text("Welcome To Project PNC")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .foregroundColor(.accentColor)
                                .padding(.top)
                            Spacer()
                            Text("PNC is made as an alternative to scrolling on social media. We believe that your desire to scrol should not keep you from education ").font(.title2)
                                .fontWeight(.medium)
                                .multilineTextAlignment(.center)
                                .padding([.top, .leading, .trailing], 35.0)
                                .foregroundColor(.gray)
                            Spacer()
                            Text("You can get started with adding books using the navigation bar on the top left of your screen").font(.title2)
                                .fontWeight(.medium)
                                .multilineTextAlignment(.center)
                                .padding([.top, .leading, .trailing], 35)
                                .foregroundColor(.gray)
                        }
                        else{
                            Text("PNC")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .foregroundColor(.accentColor)
                                .padding(.top)
                        }
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
                .frame(maxWidth: .infinity)
                .padding()

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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

