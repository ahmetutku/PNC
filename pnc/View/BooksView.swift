//
//  FavoritesView.swift
//  pnc
//
//  Created by Ahmet Hamamcioglu on 9.12.2024.
//

import SwiftUI

struct BooksView: View {
    @ObservedObject var model: BookRowModel

    var body: some View {
        VStack(spacing: 20) {
            Text("My Books")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top)

            ScrollView {
                ForEach(model.favoriteBooks) { book in
                    NavigationLink(destination: BookDetailView(book: book, model: model)) {
                        BookRowView(book: book, model: model)
                    }
                }.padding()
            }.listStyle(PlainListStyle())

            Spacer()
        }
        .padding()
        .background(Color("beigeColor").ignoresSafeArea())
    }
}
