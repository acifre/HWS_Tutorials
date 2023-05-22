//
//  Bundle-Decodable.swift
//  Moonshot
//
//  Created by Anthony Cifre on 5/17/23.
//

import Foundation

extension Bundle {
    func decode<T: Codable>(_ file: String) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle.")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle.")
        }
        
        let decoder = JSONDecoder()
        let formatter = DateFormatter()
        formatter.dateFormat = "y-MM-dd"
        decoder.dateDecodingStrategy = .formatted(formatter) // when you find dates they will be in the above format
        
        guard let loaded = try? decoder.decode(T.self, from: data) else {
            fatalError("Failed to deocde \(file) from bundle.")
        }
        
        return loaded
    }
}
