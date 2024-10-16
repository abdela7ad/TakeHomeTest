
//
//  CharacterListViewModel.swift
//  YassirInterview
//
//  Created by Abdelahad on 15/10/2024.
//

import Foundation
import Combine

final class CharacterListViewModel {
    @Published var characters: [Character] = []
    @Published var clearDatasource: Bool = false
    
    private var nextPageUrlString: String?
    private var previousPageUrlString: String?
    private var currentPage = 1
    private var statusFilter: Status?
     
    private let characterRepository: CharacteRepository
    private let logProvider: LogProvider
    
    init(characterRepository: CharacteRepository, logProvider: LogProvider) {
        self.characterRepository = characterRepository
        self.logProvider = logProvider
    }
    
    func viewDidLoad() async {
         await loadCharacters()
    }
    
    func didEndScroll() async {
        await loadMore()
    }
    
    func filterCharacters(by status: String) async  {
        guard let status = Status(rawValue: status) else { return }
        if statusFilter == status {
            statusFilter = nil
            currentPage = 1
            await loadCharacters()
        } else {
            clearDatasource = true
            statusFilter = status
            do {
                let pageResults = try await characterRepository.filterCharacters(with: status)
                processPageResults(pageResults)
            } catch  {
                logProvider.error(error: error)
            }
        }
    }
    
    private func loadMore() async {
        guard let nextPageUrlString, nextPageUrlString != previousPageUrlString else { return }
        currentPage += 1
        do {
            let pageResults = try await characterRepository.charactersPageInfo(currentPage, status: statusFilter)
            processPageResults(pageResults)
        } catch  {
            logProvider.error(error: error)
        }
    }
    
    private func loadCharacters() async {
        do {
            let pageResults = try await characterRepository.charactersPageInfo(currentPage)
            processPageResults(pageResults)
        } catch  {
            logProvider.error(error: error)
        }
        
    }
    private func processPageResults( _ pageResults: CharactersResult) {
        characters = pageResults.results
        nextPageUrlString = pageResults.info.next
        previousPageUrlString = pageResults.info.prev
    }
}
