//
//  CharacterStatusFilterReusableView.swift
//  YassirInterview
//
//  Created by Abdelahad on 15/10/2024.
//

import UIKit
import SwiftUI

class CharacterStatusFilterReusableView: UICollectionReusableView {
    
    override init(frame: CGRect = .zero) { super.init(frame: frame) }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func host(_ view: AnyView) {
        let config = UIHostingConfiguration(content: { view })
        let subview = config.makeContentView()
        subview.translatesAutoresizingMaskIntoConstraints = false
        subview.backgroundColor = .white
        addSubview(subview)
        NSLayoutConstraint.activate([
            subview.topAnchor.constraint(equalTo: self.topAnchor),
            subview.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            subview.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            subview.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}

extension UICollectionReusableView {
    public static var Identifier: String { return String(describing: self) }
}
