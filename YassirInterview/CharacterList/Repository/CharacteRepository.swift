
//
//  CharacteRepository.swift
//  YassirInterview
//
//  Created by Abdelahad on 15/10/2024.
//

import UIKit

protocol CharacteRepository {
    func charactersPageInfo(_ page: Int, status: Status?) async throws -> CharactersResult
    func filterCharacters(with status: Status) async throws -> CharactersResult
}

extension CharacteRepository {
    func charactersPageInfo(_ page: Int) async throws -> CharactersResult {
        try await charactersPageInfo(page, status: nil)
    }
}

final class MainCharacteRepository: CharacteRepository {
    private let service: CharacterService
    
    init(service: CharacterService) {
        self.service = service
    }
    
    func charactersPageInfo(_ page: Int, status: Status?) async throws -> CharactersResult {
        return try await service.charactersPageInfo(page, status: status?.rawValue)
    }
    
    func filterCharacters(with status: Status) async throws -> CharactersResult {
        return try await service.filterCharacters(with: status.rawValue)
    }
}

