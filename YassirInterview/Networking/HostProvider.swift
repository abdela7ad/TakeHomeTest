//
//  HostProvider.swift
//  YassirInterview
//
//  Created by Abdelahad on 15/10/2024.
//
import Foundation

protocol HostProvider {
    func getHost() -> URL
}

struct CharacterHostProvider: HostProvider {
    func getHost() -> URL {
        return URL(staticString: "https://rickandmortyapi.com")
    }
}
