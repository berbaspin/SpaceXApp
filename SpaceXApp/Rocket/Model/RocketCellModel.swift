//
//  MainCellModel.swift
//  SpaceXApp
//
//  Created by Dmitry Babaev on 05.06.2022.
//

import Foundation

struct RocketCellModel: Hashable {
    let id = UUID()
    let title: String
    let value: String
    let measuringSystem: String
}
