//
//  AppFlow.swift
//  YassirInterview
//
//  Created by Abdelahad on 16/10/2024.
//
import Foundation
import UIKit

final class AppFlow: NSObject {
    public static let shared: AppFlow = AppFlow()
    public var window: UIWindow!
    
    private let appDependacy = AppDependacyContainer.shared
    
    public func startFlow(window: UIWindow) {
        self.window = window
        presentRootViewController()
    }
    
    private func presentRootViewController() {
        let characterRepository = appDependacy.characterDependencyContainer.makeCharacterRepository()
        let controller = CharacterListViewController(
            viewModel: CharacterListViewModel(
                characterRepository: characterRepository,
                logProvider:appDependacy.logProvider
            )
        )
        window.rootViewController = UINavigationController(rootViewController: controller)
        window.makeKeyAndVisible()
    }
}

