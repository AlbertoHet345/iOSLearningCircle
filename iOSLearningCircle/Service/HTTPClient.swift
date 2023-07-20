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
    
    static func loadPokedex() async throws -> [Pokemon] {
        guard let url = URL(string: "https://pokedex-bb36f.firebaseio.com/pokemon.json") else {
            throw HTTPError.badURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw HTTPError.basResponse
        }
        
        let decoder = JSONDecoder()
        if let data = data.parseData(removeString: "null,") {
            guard let pokedex = try? decoder.decode([Pokemon].self, from: data) else {
                throw HTTPError.decoding
            }
            
            return pokedex
        } else {
            return []
        }
    }
}

struct Pokemon: Decodable {
    let id: Int
    let name: String
    let imageUrl: String
    let type: PokemonType
}

import UIKit

enum PokemonType: String, Decodable {
    case bug
    case dragon
    case electric
    case fairy
    case fighting
    case fire
    case flying
    case ghost
    case grass
    case ground
    case ice
    case normal
    case poison
    case psychic
    case rock
    case steel
    case water
    
    var color: UIColor {
        UIColor(named: self.rawValue) ?? .white
    }
}

extension Data{
    func parseData(removeString string: String ) -> Data? {
        let dataAsString = String(data: self, encoding: .utf8)
        let parsedDataString = dataAsString?.replacingOccurrences(of: string, with: "")
        guard let data = parsedDataString?.data(using: .utf8) else {return nil}
        return data
    }
}
