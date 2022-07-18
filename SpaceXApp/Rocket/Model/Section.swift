//
//  Section.swift
//  SpaceXApp
//
//  Created by Dmitry Babaev on 30.06.2022.
//

import Foundation

struct Section: Hashable {
    let id = UUID()
    let type: SectionType
    let cellModels: [RocketCellModel]
}

// MARK: SectionType

extension Section {
    enum SectionType: String {
        case parameters
        case information
        case firstStage = "FIRST STAGE"
        case secondStage = "SECOND STAGE"
    }
}
