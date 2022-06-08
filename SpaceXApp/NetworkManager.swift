//
//  NetworkManager.swift
//  SpaceXApp
//
//  Created by Dmitry Babaev on 27.05.2022.
//

import Moya

enum NetworkManager {
    case getRockets
}

extension NetworkManager: TargetType {
    var baseURL: URL {
        URL(string: "https://api.spacexdata.com")!
    }

    var path: String {
        switch self {
        case .getRockets:
            return "/v4/rockets"
        }
    }

    var method: Method {
        .get
    }

    var data: Data {
        Data()
    }

    var task: Task {
        .requestPlain
    }

    var headers: [String : String]? {
        ["Content-Type": "application/json"]
    }

    var validationType: ValidationType {
        .successCodes
    }

}
