//
//  BookLoader.swift
//  pnc
//
//  Created by Ahmet Hamamcioglu on 24.12.2024.
//

import Foundation

struct BookLoader {
    private static let filePath = "/Users/ahmethamamcioglu/Desktop/pnc_overview/pnc/pnc/bookData/generalInfo.json"

    static func loadBooks() -> [Book] {
        let url = URL(fileURLWithPath: filePath)

        guard FileManager.default.fileExists(atPath: filePath) else {
            print("Error: JSON file not found at specified path: \(filePath)")
            return []
        }

        do {
            let data = try Data(contentsOf: url)
            let decodedBooks = try JSONDecoder().decode([Book].self, from: data)
            return decodedBooks
        } catch {
            print("Error loading or decoding JSON: \(error)")
            return []
        }
    }

    static func performSearch(books: [Book], query: String) -> [Book] {
        guard !query.isEmpty else {
            return books
        }
        
        print(books.filter {
            $0.title.localizedCaseInsensitiveContains(query) ||
            $0.author.localizedCaseInsensitiveContains(query)
        })

        return books.filter {
            $0.title.localizedCaseInsensitiveContains(query) ||
            $0.author.localizedCaseInsensitiveContains(query)
        }
    }
}
