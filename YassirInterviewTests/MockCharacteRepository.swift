//
//  MockCharacteRepository.swift
//  YassirInterview
//
//  Created by Abdelahad on 16/10/2024.
//

@testable import YassirInterview
class MockCharacteRepository: CharacteRepository {
    var currentPageNumber: Int = 0
    var filterCharactersCallCount: Int = 0
    var filterStatus: YassirInterview.Status?

    func charactersPageInfo(_ page: Int, status: YassirInterview.Status?) async throws -> YassirInterview.CharactersResult {
        currentPageNumber = page
        filterStatus = status
        return YassirInterview.CharactersResult(
            info: Info(count: 5, pages: 50, next: "nextURL", prev: "prevtURL"),
            results:         [
                Character(id: 1, name: "A", status: .alive, species: "s", type: "type", image: "image", episode: [], url: "url", created: "created", location: Location(name: "loc", url: "url"), gender: "male"),
                Character(id: 2, name: "A", status: .alive, species: "s", type: "type", image: "image", episode: [], url: "url", created: "created", location: Location(name: "loc", url: "url"), gender: "male")
            ])
    }
    
    func filterCharacters(with status: YassirInterview.Status) async throws -> YassirInterview.CharactersResult {
        filterCharactersCallCount += 1
        filterStatus = status
        return YassirInterview.CharactersResult(
            info: Info(count: 5, pages: 50, next: "nextURL", prev: "prevtURL"),
            results: [Character(id: 2, name: "A", status: status, species: "s", type: "type", image: "image", episode: [], url: "url", created: "created", location: Location(name: "loc", url: "url"), gender: "male")])
    }
}

class MockLogProvider: LogProvider {
    var internalErrorCalledCount: Int = 0
    func internalError(context: [String : Any]?, error: (any Error)?, file: String, method: String, line: Int) {
        internalErrorCalledCount += 1
    }
}
