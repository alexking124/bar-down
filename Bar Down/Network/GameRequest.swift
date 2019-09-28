//
//  GameRequest.swift
//  Bar Down
//
//  Created by Alex King on 9/27/19.
//  Copyright © 2019 Pryanik. All rights reserved.
//

import Foundation

struct GameRequest: Request {
    typealias ResponseType = GameResponse
    
    let gameID: Int
    
    var url: URL {
        return URL(string: "https://statsapi.web.nhl.com/api/v1/game/\(gameID)/feed/live")!
    }
}

struct GameResponse: Codable {
    let gamePk: Int
    let gameData: GameDataResponse
    let liveData: LiveDataResponse
}

struct GameDataResponse: Codable {
    struct DateTime: Codable {
        let dateTime: String
    }
    
    let datetime: DateTime
    let status: GameStatusResponse
}

struct LiveDataResponse: Codable {
    let linescore: LinescoreResponse
}

struct LinescoreResponse: Codable {
    let currentPeriod: Int
    let currentPeriodOrdinal: String
    let currentPeriodTimeRemaining: String
    let periods: [LinescorePeriodResponse]
    let hasShootout: Bool
    let powerPlayStrength: String
    let intermissionInfo: IntermissionInfoResponse
}

struct IntermissionInfoResponse: Codable {
    let intermissionTimeRemaining: Int
    let intermissionTimeElapsed: Int
    let inIntermission: Int
}

struct LinescorePeriodResponse: Codable {
    struct TeamPeriodResult: Codable {
        let goals: Int
        let shotsOnGoal: Int
    }
    
    let periodType: String
    let num: Int
    let ordinalNum: String
    let home: TeamPeriodResult
    let away: TeamPeriodResult
}