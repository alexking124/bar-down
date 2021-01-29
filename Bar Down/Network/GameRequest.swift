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
    let plays: PlaysResponse
    let linescore: LinescoreResponse
}

struct LinescoreResponse: Codable {
    let currentPeriod: Int?
    let currentPeriodOrdinal: String?
    let currentPeriodTimeRemaining: String?
    let periods: [LinescorePeriodResponse]
    let hasShootout: Bool
    let powerPlayStrength: String
    let intermissionInfo: IntermissionInfoResponse?
    let teams: LinescoreTeamsResponse
}

struct LinescoreTeamsResponse: Codable {
    let home: LinescoreTeamResponse
    let away: LinescoreTeamResponse
}

struct LinescoreTeamResponse: Codable {
    let goals: Int
    let shotsOnGoal: Int
    let goaliePulled: Bool
    let numSkaters: Int
    let powerPlay: Bool
}

struct IntermissionInfoResponse: Codable {
    let intermissionTimeRemaining: Int
    let intermissionTimeElapsed: Int
    let inIntermission: Bool
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

struct PlaysResponse: Codable {
    let allPlays: [GamePlayResponse]
    let scoringPlays: [Int]
    let penaltyPlays: [Int]
}

struct GamePlayResponse: Codable {
    struct Result: Codable {
        struct Strength: Codable {
            let code: String
            let name: String
        }
        let eventTypeId: String
        let eventCode: String
        let description: String
        let strength: Strength?
      let secondaryType: String?
      let emptyNet: Bool?
      let gameWinningGoal: Bool?
    }
    struct About: Codable {
        let period: Int
        let periodTime: String
        let eventIdx: Int
    }
    struct Player: Codable {
        struct Details: Codable {
            let id: Int
            let fullName: String
        }
        let playerType: String
        let seasonTotal: Int?
        let player: Details
    }
    struct Team: Codable {
        let id: Int
        let name: String
        let triCode: String
    }
    
    let players: [Player]?
    let result: Result
    let about: About
    let team: Team?
}
