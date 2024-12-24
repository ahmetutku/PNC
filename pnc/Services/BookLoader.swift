import Foundation

struct BookLoader {
    static func loadBooks(from filePath: String) -> [Book] {
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
}
