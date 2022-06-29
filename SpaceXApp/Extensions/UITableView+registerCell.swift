//
//  UITableView+registerCell.swift
//  SpaceXApp
//
//  Created by Dmitry Babaev on 13.06.2022.
//

import UIKit

extension UITableView {
    func registerCell(type: UITableViewCell.Type, identifier: String? = nil) {
        let cellId = String(describing: type)
        register(type, forCellReuseIdentifier: identifier ?? cellId)
    }

    func dequeueCell<T: UITableViewCell>(type: UITableViewCell.Type, for indexPath: IndexPath) -> T? {
        let cellId = String(describing: type)
        return dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? T
    }
}
