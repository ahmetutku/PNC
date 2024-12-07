struct QuoteView: View {
    let quote: Quote
    @ObservedObject var viewModel: QuotesViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            // Quote text
            Text("\"\(quote.text)\"")
                .font(.body)
                .multilineTextAlignment(.leading)
                .foregroundColor(.primary)

            // Author
            Text("- \(quote.author)")
                .font(.subheadline)
                .foregroundColor(.secondary)

            // Favorite button
            HStack {
                Spacer()
                Button(action: {
                    viewModel.toggleFavorite(quote)
                }) {
                    Image(systemName: viewModel.favoriteQuotes.contains(quote) ? "star.fill" : "star")
                        .foregroundColor(viewModel.favoriteQuotes.contains(quote) ? .yellow : .gray)
                }
            }
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
        .shadow(radius: 2)
        .padding(.vertical, 4)
    }
}
