//
//  Book.swift
//  pnc
//
//  Created by Ahmet Hamamcioglu on 1.12.2024.
//

import Foundation

struct Book: Identifiable, Decodable {
    let id: UUID
    let title: String
    let author: String
    let year: Int
    let description: String
    let quotes: [String] // Add quotes array to the model

    enum CodingKeys: String, CodingKey {
        case id, title, author, year, description, quotes
    }
    
    init(id: UUID, title: String, author: String, year: Int, description: String, quotes: [String]) {
            self.id = id
            self.title = title
            self.author = author
            self.year = year
            self.description = description
            self.quotes = quotes
        }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(UUID.self, forKey: .id) ?? UUID() // Default UUID if not present
        self.title = try container.decode(String.self, forKey: .title)
        self.author = try container.decode(String.self, forKey: .author)
        self.year = try container.decode(Int.self, forKey: .year)
        self.description = try container.decode(String.self, forKey: .description)
        self.quotes = try container.decodeIfPresent([String].self, forKey: .quotes) ?? []
    }
}


