//
//  Section.swift
//  SpaceXApp
//
//  Created by Dmitry Babaev on 30.06.2022.
//

import Foundation

struct Section: Hashable {
    // let id = UUID()
    let type: SectionType
    let cellModels: [RocketCellModel]
}

// MARK: SectionType

extension Section {
    enum SectionType {
        case parameters
        case information
        case firstStage
        case secondStage

        var name: String {
            switch self {
            case .parameters:
                return "Parameters".localized().uppercased()
            case .information:
                return "Information".localized().uppercased()
            case .firstStage:
                return "First stage".localized().uppercased()
            case .secondStage:
                return "Second stage".localized().uppercased()
            }
        }
    }
}
