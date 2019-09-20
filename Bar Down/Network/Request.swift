//
//  Request.swift
//  Bar Down
//
//  Created by Alex King on 8/27/19.
//  Copyright © 2019 Pryanik. All rights reserved.
//

import Foundation

protocol Request {
    associatedtype ResponseType: Decodable
    var url: URL { get }
}

extension Request {
    func deserialize(_ data: Data) throws -> ResponseType {
        return try JSONDecoder().decode(ResponseType.self, from: data)
    }
}

struct CurrentSeasonRequest: Request {
    typealias ResponseType = CurrentSeasonResponse
    let url = URL(string: "https://statsapi.web.nhl.com/api/v1/seasons/current")!
}

struct CurrentSeasonResponse: Decodable {
    let seasons: [SeasonResponse]
}

struct SeasonResponse: Decodable {
    let seasonId: String
    let regularSeasonStartDate: String
    let regularSeasonEndDate: String
    let seasonEndDate: String
    let numberOfGames: Int
}
