//
//  CharacterService.swift
//  YassirInterview
//
//  Created by Abdelahad on 15/10/2024.
//

import Foundation

protocol CharacterService {
    func charactersPageInfo(_ page: Int, status: String?) async throws -> CharactersResult
    func filterCharacters(with status: String) async throws -> CharactersResult
}

extension CharacterService {
    func charactersPageInfo(_ page: Int) async throws -> CharactersResult {
        try await charactersPageInfo(page, status: nil)
    }
}

final class MainCharacterService: CharacterService {
    private let networkProvider: NetworkProvider
    private let hostProvider: HostProvider

    init(networkProvider: NetworkProvider, hostProvider: HostProvider) {
        self.networkProvider = networkProvider
        self.hostProvider = hostProvider
    }
    
    func charactersPageInfo(_ page: Int, status: String?) async throws -> CharactersResult {
        var url = hostProvider
            .getHost()
            .appendingPathComponent("api")
            .appendingPathComponent("character")
            .appending(queryItems: [
                URLQueryItem(name: "page", value: "\(page)")
            ])
        if let status {
            url = url.appending(queryItems: [
                    URLQueryItem(name: "status", value: "\(status)")
                ])
        }
        return try await networkProvider.sendAndRetrieve(method: .get, destination: url)
    }
    
    func filterCharacters(with status: String) async throws -> CharactersResult {
        let url = hostProvider
            .getHost()
            .appendingPathComponent("api")
            .appendingPathComponent("character")
            .appending(queryItems: [
                URLQueryItem(name: "status", value: "\(status)")
            ])
        return try await networkProvider.sendAndRetrieve(method: .get, destination: url)
    }
}
