//
//  CharacterDependencyContainer.swift
//  YassirInterview
//
//  Created by Abdelahad on 16/10/2024.
//

final class CharacterDependencyContainer {
    init(networkProvider: NetworkProvider, hostProvider: HostProvider) {
        self.hostProvider = hostProvider
        self.networkProvider = networkProvider
        self.service = MainCharacterService(
            networkProvider: networkProvider,
            hostProvider: hostProvider
        )
    }
    
    func makeCharacterRepository() -> CharacteRepository {
        MainCharacteRepository(service: service)
    }
    
    private let networkProvider: NetworkProvider
    private let hostProvider: HostProvider
    private let service: CharacterService
}

