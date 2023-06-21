//
//  HTTPClient.swift
//  iOSLearningCircle
//
//  Created by Alberto Garcia on 13/06/23.
//

import Foundation

enum HTTPError: Error {
    case badURL
    case basResponse
    case decoding
}

struct Wrapper: Decodable {
    let items: [Product]
    
    enum CodingKeys: String, CodingKey {
        case items = "products"
    }
}

struct Product: Decodable {
    let title: String
    let price: Double
    let description: String
    let images: [String]
}

final class HTTPClient {
    static func load() async throws -> Wrapper {
        guard let url = URL(string: "https://dummyjson.com/products") else {
            throw HTTPError.badURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw HTTPError.basResponse
        }
        
        let decoder = JSONDecoder()
        guard let wrapper = try? decoder.decode(Wrapper.self, from: data) else {
            throw HTTPError.decoding
        }
        
        return wrapper
    }
}
