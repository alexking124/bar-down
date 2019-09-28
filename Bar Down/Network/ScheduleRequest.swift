//
//  ScheduleRequest.swift
//  Bar Down
//
//  Created by Alex King on 9/7/19.
//  Copyright © 2019 Pryanik. All rights reserved.
//

import Foundation

struct ScheduleRequest: Request {
    typealias ResponseType = ScheduleResponse
    
    let date: Date
    
    private let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter
    }()
    
    var url: URL {
        let dateString = dateFormatter.string(from: date)
        let dateQuery = "?startDate=\(dateString)&endDate=\(dateString)"
        return URL(string: "https://statsapi.web.nhl.com/api/v1/schedule\(dateQuery)&expand=schedule.game.seriesSummary")!
    }
}

struct ScheduleResponse: Codable {
    let dates: [GameDate]
}

struct GameDate: Codable {
    let date: String
    let totalGames: Int
    let games: [ScheduledGame]
}

struct GameStatusResponse: Codable {
    let abstractGameState: String
    let codedGameState: String
    let detailedState: String
    let statusCode: String
}

struct ScheduledGame: Codable {
    let gamePk: Int
    let gameDate: String
    let gameType: String
    let status: GameStatusResponse
    let teams: ScheduledGameTeams
    
    var date: Date? {
        return DateFormatter.gameDateFormatter.date(from: gameDate)
    }
}

struct ScheduledGameTeams: Codable {
    struct GameTeam: Codable {
        struct Team: Codable {
            let id: Int
        }
        let team: Team
        let score: Int
    }
    let home: GameTeam
    let away: GameTeam
}
