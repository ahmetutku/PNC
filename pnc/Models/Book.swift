//
//  Book.swift
//  pnc
//
//  Created by Ahmet Hamamcioglu on 1.12.2024.
//


import Foundation

struct Book: Identifiable, Decodable {
    let id: UUID// Unique ID for SwiftUI
    let title: String
    let author: String
    let year: Int
    let description: String
    
    init(id: UUID = UUID(), title: String, author: String, year: Int, description: String) {
        self.id = id
        self.title = title
        self.author = author
        self.year = year
        self.description = description
    }
}