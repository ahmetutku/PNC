//
//  BookRowModel.swift
//  pnc
//
//  Created by Ahmet Hamamcioglu on 9.12.2024.
//
import SwiftUI
class BookRowModel: ObservableObject {
    @Published var favoriteBooks: [Book]

    init(favoriteBooks: [Book] = []) {
        self.favoriteBooks = favoriteBooks
    }

    func addToMyBooks(_ book: Book) {
        if favoriteBooks.contains(where: { $0.title == book.title }) {
            favoriteBooks.removeAll { $0.title == book.title }
        } else {
            favoriteBooks.append(book)
        }
        _ = favoriteBooks.map { "\($0.title) (ID: \($0.id))" }.joined(separator: ", ")
    }
    
}
