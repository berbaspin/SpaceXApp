//
//  UICollectionView+registerCell.swift
//  SpaceXApp
//
//  Created by Dmitry Babaev on 13.06.2022.
//

import UIKit

extension UICollectionView {
    func registerCell<T: UICollectionViewCell>(type: T.Type, identifier: String = String(describing: T.self)) {
        register(type, forCellWithReuseIdentifier: identifier)
    }

    func dequeueCell<T: UICollectionViewCell>(type: UICollectionViewCell.Type, for indexPath: IndexPath) -> T? {
        let cellId = String(describing: type)
        return dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? T
    }
}
