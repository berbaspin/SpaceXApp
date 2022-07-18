//
//  UITableView+registerCell.swift
//  SpaceXApp
//
//  Created by Dmitry Babaev on 13.06.2022.
//

import UIKit

extension UITableView {
    func registerCell<T: UITableViewCell>(type: T.Type, identifier: String = String(describing: T.self)) {
        register(type, forCellReuseIdentifier: identifier)
    }

    func dequeueCell<T: UITableViewCell>(type: UITableViewCell.Type, for indexPath: IndexPath) -> T? {
        let cellId = String(describing: type)
        return dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? T
    }
}
