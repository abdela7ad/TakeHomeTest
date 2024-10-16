//
//  CharacterCollectionViewCell.swift
//  YassirInterview
//
//  Created by Abdelahad on 15/10/2024.
//

import UIKit
import SwiftUI

class CharacterCollectionViewCell: UICollectionViewCell {
    override func prepareForReuse() {
        super.prepareForReuse()
        contentConfiguration = nil
    }
    
    func configure(with character: Character) {
        contentConfiguration = UIHostingConfiguration(content: {
            CharacterView(character: character)
        })
    }
}
