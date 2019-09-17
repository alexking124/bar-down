//
//  TeamsRequest.swift
//  Bar Down
//
//  Created by Alex King on 9/8/19.
//  Copyright © 2019 Pryanik. All rights reserved.
//

import Foundation

struct TeamsRequest: Request {
    typealias ResponseType = TeamsResponse
    let url = URL(string: "https://statsapi.web.nhl.com/api/v1/teams")!
}

struct TeamsResponse: Codable {
    let teams: [TeamResponse]
}

struct TeamResponse: Codable {
    let id: Int
    let name: String
    let abbreviation: String
    let teamName: String
    let shortName: String
}
