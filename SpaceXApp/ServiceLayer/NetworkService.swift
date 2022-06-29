//
//  NetworkService.swift
//  SpaceXApp
//
//  Created by Dmitry Babaev on 27.05.2022.
//

import Moya

enum NetworkService {
    case getRockets
    case getLaunches
}

extension NetworkService: TargetType {
    var baseURL: URL {
        URL(string: "https://api.spacexdata.com")!
    }

    var path: String {
        switch self {
        case .getRockets:
            return "/v4/rockets"
        case .getLaunches:
            return "/v4/launches"
        }
    }

    var method: Method {
        .get
    }

    var sampleData: Data {
        Data()
    }

    var task: Task {
        .requestPlain
    }

    var headers: [String: String]? {
        ["Content-Type": "application/json"]
    }

}
