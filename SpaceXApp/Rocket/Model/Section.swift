//
//  Section.swift
//  SpaceXApp
//
//  Created by Dmitry Babaev on 30.06.2022.
//

import Foundation

final class Section: Hashable {
    let id = UUID()
    let type: SectionType
    let cellModels: [RocketCellModel]

    init(type: SectionType, cellModels: [RocketCellModel]) {
        self.type = type
        self.cellModels = cellModels
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func == (lhs: Section, rhs: Section) -> Bool {
        lhs.id == rhs.id
    }
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
