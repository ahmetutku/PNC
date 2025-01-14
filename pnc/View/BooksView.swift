//
//  FavoritesView.swift
//  pnc
//
//  Created by Ahmet Hamamcioglu on 9.12.2024.
//

import SwiftUI

struct BooksView: View {
    @ObservedObject var bookRowModel: BookRowModel
    @State private var books: [Book] = []

    var body: some View {
        VStack(spacing: 20) {
            Text("My Books")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top)
            if(bookRowModel.favoriteBooks.isEmpty){
                Spacer()
                Text("Favorited Books is Empty")
                Spacer()
            }

            ScrollView {
                ForEach(bookRowModel.favoriteBooks) { book in
                    NavigationLink(destination: BookDetailView(book: book, model: bookRowModel)) {
                        BookRowView(book: book, model: bookRowModel)
                    }
                    
                    
                }.padding()
            }.listStyle(PlainListStyle())
            Spacer()
        }.onAppear(){
            books = BookLoader.loadBooks()
            print(books.count)

        }
        .padding()
        .background(Color("beigeColor").ignoresSafeArea())
    }
}
