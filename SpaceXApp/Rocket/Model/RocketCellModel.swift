//
//  MainCellModel.swift
//  SpaceXApp
//
//  Created by Dmitry Babaev on 05.06.2022.
//

import Foundation

final class RocketCellModel: Hashable {
    let id = UUID()
    let title: String
    let value: String
    let measuringSystem: String

    init(title: String, value: String, measuringSystem: String) {
        self.title = title
        self.value = value
        self.measuringSystem = measuringSystem
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func == (lhs: RocketCellModel, rhs: RocketCellModel) -> Bool {
        lhs.id == rhs.id
    }
}
