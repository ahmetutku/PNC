//
//  BookRowModel.swift
//  pnc
//
//  Created by Ahmet Hamamcioglu on 9.12.2024.
//

import SwiftUI

class BookRowModel: ObservableObject {
    @Published var favoriteBooks: [Book] = [] // Saved favorite quotes

    func addToMyBooks(_ book: Book) {
        if favoriteBooks.contains(where: { $0.id == book.id }) {
            favoriteBooks.removeAll { $0.id == book.id }
        } else {
            favoriteBooks.append(book)
        }
    }
}
