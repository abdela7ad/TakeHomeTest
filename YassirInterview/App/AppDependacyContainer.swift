
//
//  AppDependacyContainer.swift
//  YassirInterview
//
//  Created by Abdelahad on 16/10/2024.
//

final class AppDependacyContainer {
    
    static let shared = AppDependacyContainer()
    
    private let networkProvider: NetworkProvider
    private let characterHostProvider: HostProvider
    private(set) var logProvider: LogProvider
    init() {
        self.networkProvider = BasicNetworkProvider()
        self.characterHostProvider = CharacterHostProvider()
        self.logProvider = ConsoleLogger()
    }
    
    lazy var characterDependencyContainer: CharacterDependencyContainer = {
        return CharacterDependencyContainer(
            networkProvider: networkProvider,
            hostProvider: characterHostProvider
        )
    }()
}
