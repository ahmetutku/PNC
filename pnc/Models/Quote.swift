//
//  Quote.swift
//  pnc
//
//  Created by Ahmet Hamamcioglu on 9.12.2024.
//
import SwiftUI

struct Quote: Identifiable, Equatable {
    let id = UUID()
    let text: String
    let author: String

    static let sampleQuotes: [Quote] = [
        Quote(text: "The only limit to our realization of tomorrow is our doubts of today.", author: "Franklin D. Roosevelt"),
        Quote(text: "Success is not final, failure is not fatal: It is the courage to continue that counts.", author: "Winston Churchill"),
        Quote(text: "Do not wait to strike till the iron is hot; but make it hot by striking.", author: "William Butler Yeats"),
        Quote(text: "Do not wait to strike till the iron is hot; but make it hot by striking.", author: "William Butler Yeats"),
        Quote(text: "Do not wait to strike till the iron is hot; but make it hot by striking.", author: "William Butler Yeats"),
        Quote(text: "Do not wait to strike till the iron is hot; but make it hot by striking.", author: "William Butler Yeats")
    ]
}
