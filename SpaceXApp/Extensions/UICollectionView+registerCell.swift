//
//  UICollectionView+registerCell.swift
//  SpaceXApp
//
//  Created by Dmitry Babaev on 13.06.2022.
//

import UIKit

extension UICollectionView {
    func registerCell(type: UICollectionViewCell.Type, identifier: String? = nil) {
        let cellId = String(describing: type)
        register(type, forCellWithReuseIdentifier: identifier ?? cellId)
    }

    func dequeueCell<T: UICollectionViewCell>(type: UICollectionViewCell.Type, for indexPath: IndexPath) -> T? {
        let cellId = String(describing: type)
        return dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? T
    }
}
