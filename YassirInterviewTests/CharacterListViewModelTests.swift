//
//  CharacterListViewModelTests.swift
//  YassirInterview
//
//  Created by Abdelahad on 16/10/2024.
//

import Testing
@testable import YassirInterview

final class CharacterListViewModelTests {
    private let mockRepository = MockCharacteRepository()
    private let mockLogger = MockLogProvider()
    private let sut: CharacterListViewModel
    init() {
         sut =  CharacterListViewModel(characterRepository: mockRepository, logProvider: mockLogger)
    }
   
    @Test func viewDidLoad_getCharactersForFirstPage() async {
        await sut.viewDidLoad()
        #expect(mockRepository.currentPageNumber == 1)
        #expect(sut.characters.count == 2)
    }

    @Test func testDidScrollEnd_LoadMore() async {
        await sut.viewDidLoad()
        await sut.didEndScroll()
        #expect(mockRepository.currentPageNumber == 2)
        #expect(sut.characters.count == 2)
    }
    
    @Test func testFilterCharactersByStatus() async {
        await sut.filterCharacters(by: "Alive")
        #expect(mockRepository.filterCharactersCallCount == 1)
        #expect(mockRepository.filterStatus == .alive)
        #expect(sut.characters.count == 1)
    }
}
