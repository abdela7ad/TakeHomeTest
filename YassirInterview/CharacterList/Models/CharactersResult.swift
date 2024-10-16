//
//  CharactersResult.swift
//  YassirInterview
//
//  Created by Abdelahad on 14/10/2024.
//

struct CharactersResult: Codable {
    let info: Info
    let results: [Character]
}

struct Info: Codable {
    let count, pages: Int
    let next, prev: String?
}

struct Character: Codable, Hashable {
    let id: Int
    let name: String
    let status: Status
    let species: String
    let type: String
    let image: String
    let episode: [String]
    let url: String
    let created: String
    let location: Location
    let gender: String

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

enum Status: String, Codable, CaseIterable {
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "unknown"
}

struct Location: Codable, Hashable {
    let name: String
    let url: String?
}
