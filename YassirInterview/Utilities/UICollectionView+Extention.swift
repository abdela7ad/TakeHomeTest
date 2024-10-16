//
//  UICollectionView+Extention.swift
//  YassirInterview
//
//  Created by Abdelahad on 15/10/2024.
//

import UIKit

extension UICollectionView {
    func register<T: UICollectionViewCell>(cell: T.Type) {
        register(T.self, forCellWithReuseIdentifier: T.Identifier)
    }
    
    func register<T: UICollectionReusableView>(header: T.Type) {
        register(T.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: T.Identifier)
    }

    func dequeue<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
        return dequeueReusableCell(withReuseIdentifier: T.Identifier, for: indexPath) as! T
    }
    
    func dequeueReusableSupplementaryView<T: UICollectionReusableView>(ofKind kind: String , for indexPath: IndexPath) -> T {
        dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: T.Identifier, for: indexPath) as! T
    }
}
