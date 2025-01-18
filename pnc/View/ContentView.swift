import SwiftUI

struct ContentView: View {
    @StateObject var quotesViewModel = QuotesViewModel()
    @StateObject var bookRowModel = BookRowModel()
    @State private var isMenuOpen: Bool = false
    @State private var menuPosition: CGPoint = .zero

    var body: some View {
        NavigationView {
            ZStack(alignment: .topLeading) {
                Color("background_color").ignoresSafeArea()

                VStack(spacing: 1) {
                    if(quotesViewModel.quotes.count == 0){
                        Text("Welcome To Project PNC")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.accentColor)
                            .padding(.top)

                        Spacer(minLength: 20)

                        Text("PNC is made as an alternative to scrolling on social media. We believe that your desire to scroll should not keep you from education.")
                            .font(.title2)
                            .fontWeight(.bold)
                            .multilineTextAlignment(.center)
                            .foregroundColor(Color(.subtitle))
                            .padding(.top,-80)
                            .padding(.horizontal, 35.0)
                            .foregroundColor(.gray)

                        Spacer(minLength: 20)

                        Text("You can get started with adding books using the navigation bar on the top left of your screen.")
                            .font(.title2)
                            .fontWeight(.bold)
                            .multilineTextAlignment(.center)
                            .foregroundColor(Color(.subtitle))
                            .padding(.top,-80)
                            .padding(.horizontal, 35)
                            .foregroundColor(.gray)

                        Spacer()
                    }
                    else{
                        ScrollView{
                            Spacer()
                            Text("PNC")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .foregroundColor(.accentColor)
                            Spacer()
                            ForEach(quotesViewModel.quotes) { quote in
                                QuoteRowView(
                                    quote: quote,
                                    isFavorite: quotesViewModel.favoriteQuotes.contains(quote)
                                ) {
                                    quotesViewModel.toggleFavorite(quote)
                                }
                                .padding()
                            }
                            Spacer()
                        }
                    }
                    
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
