//
//  NetworkDispatch.swift
//  Bar Down
//
//  Created by Alex King on 9/19/19.
//  Copyright © 2019 Pryanik. All rights reserved.
//

import Foundation
import CoreData

struct NetworkDispatch {
    
    public static let shared = NetworkDispatch()
    
    private let fetchQueue = DispatchQueue.global(qos: .utility)
    
    private init() {
    }
    
    public func beginUpdatingLiveScores() {
        
    }
    
    public func fetchSchedule(date: Date) {
        _ = NetworkManager.shared.publisher(for: ScheduleRequest(date: date))
            .receive(on: fetchQueue)
            .sink(receiveCompletion: { _ in }) { schedule in
                PersistenceManager.shared.persistOnBackground { objectContext in
                    schedule.dates
                        .forEach { scheduleDay in
                            let gameDatePredicate = GameDay.gameDayFetchPredicate(gameDate: scheduleDay.date)
                            guard let gameDay = try? objectContext.existingObjectOrNew(predicate: gameDatePredicate) as GameDay else {
                                return
                            }
                            gameDay.gameDate = scheduleDay.date
                            
                            let currentGameDayGames = gameDay.games?.compactMap { $0 as? Game } ?? []
                            scheduleDay.games
                                .forEach { gameData in
                                    guard let game = try? objectContext.existingObjectOrNew(predicate: Game.gameFetchPredicate(gameID: gameData.gamePk)) as Game else {
                                        return
                                    }
                                    game.gameID = Int32(gameData.gamePk)
                                    game.gameTime = gameData.date
                                    if !currentGameDayGames.contains { $0.gameID == gameData.gamePk } {
                                        gameDay.addToGames(game)
                                    }
                                    let homeTeamID = gameData.teams.home.team.id
                                    game.homeTeam = try? objectContext.fetch(Team.fetchRequestForTeam(id: homeTeamID)).first
                                    let awayTeamID = gameData.teams.away.team.id
                                    game.awayTeam = try? objectContext.fetch(Team.fetchRequestForTeam(id: awayTeamID)).first
                                }
                        }
                }
            }
    }
    
    public func fetchTeams() {
        _ = NetworkManager.shared.publisher(for: TeamsRequest())
            .receive(on: fetchQueue)
            .sink(receiveCompletion: { _ in }, receiveValue: { teamsResponse in
                PersistenceManager.shared.persistOnBackground { objectContext in
                    teamsResponse.teams.forEach { teamResponse in
                        let teamPredicate = Team.fetchPredicate(teamID: teamResponse.id)
                        guard let team = try? objectContext.existingObjectOrNew(predicate: teamPredicate) as Team else {
                            return
                        }
                        team.teamID = Int16(teamResponse.id)
                        team.abbreviation = teamResponse.abbreviation
                        team.name = teamResponse.name
                        team.teamName = teamResponse.teamName
                        team.locationName = teamResponse.locationName
                    }
                }
            })
    }
    
}
