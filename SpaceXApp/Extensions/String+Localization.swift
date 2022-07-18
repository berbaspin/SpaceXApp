//
//  String+Localization.swift
//  SpaceXApp
//
//  Created by Dmitry Babaev on 18.07.2022.
//

import Foundation

extension String {
    func localized() -> String {
        NSLocalizedString(self, tableName: "Localizable", bundle: .main, value: self, comment: self)
    }
}
