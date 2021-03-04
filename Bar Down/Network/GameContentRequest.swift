//
//  GameContentRequest.swift
//  Bar Down
//
//  Created by Alex King on 3/3/21.
//  Copyright © 2021 Pryanik. All rights reserved.
//

import Foundation

struct GameContentRequest: Request {

    typealias ResponseType = GameContentResponse

    private let gameID: Int

    init(gameID: Int) {
        self.gameID = gameID
    }

    var url: URL {
        URL(string: "http://statsapi.web.nhl.com/api/v1/game/\(gameID)/content")!
    }

}

struct GameContentResponse: Codable {
    let media: GameMediaContentResponse
}

struct GameMediaContentResponse: Codable {

}

struct GameMediaMilestonesResponse: Codable {
    struct Item: Codable {

    }
}
