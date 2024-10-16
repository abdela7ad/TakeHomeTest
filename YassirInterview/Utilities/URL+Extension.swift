//
//  Service.swift
//  YassirInterview
//
//  Created by Abdelahad on 15/10/2024.
//

import Foundation

extension URL {
    init(staticString: StaticString) {
        guard let url = URL(string: String(describing: staticString)) else {
            preconditionFailure("Invalid static URL string: \(staticString)")
        }
        self = url
    }
}
