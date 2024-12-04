//
//  BookDetailView.swift
//  pnc
//
//  Created by Ahmet Hamamcioglu on 3.12.2024.
//

import SwiftUI

struct BookDetailView: View {
    let book: Book

    var body: some View {
        Text("Detail view for \(book.title)") // Placeholder for detailed content
            .padding()
            .navigationTitle(book.title)
    }
}
