//
//  NetworkDispatch.swift
//  Bar Down
//
//  Created by Alex King on 9/19/19.
//  Copyright © 2019 Pryanik. All rights reserved.
//

import Foundation
import CoreData
import Combine

class NetworkDispatch {
    
    public static let shared = NetworkDispatch()
    
    private let fetchQueue = DispatchQueue.global(qos: .utility)
    
    private var cancellables = Set<AnyCancellable>()
    
    private init() {
    }
    
    public func beginUpdatingLiveScores() {
        
    }
    
    private func fetchGameDetails(gamePk: Int) {
        let cancellable = NetworkManager.shared.publisher(for: GameRequest(gameID: gamePk))
            .receive(on: fetchQueue)
            .sink(receiveCompletion: { _ in }, receiveValue: { response in
//                print(response.gameData.datetime)
            })
        cancellable.store(in: &cancellables)
    }
    
    public func fetchSchedule(date: Date) {
        NetworkManager.shared.publisher(for: ScheduleRequest(date: date))
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
                                    
                                    self.fetchGameDetails(gamePk: gameData.gamePk)
                                    
                                    game.gameID = Int32(gameData.gamePk)
                                    game.gameTime = gameData.date
                                    if !currentGameDayGames.contains { $0.gameID == gameData.gamePk } {
                                        gameDay.addToGames(game)
                                    }
                                    let homeTeamID = gameData.teams.home.team.id
                                    let homeTeamPredicate = Team.fetchPredicate(teamID: homeTeamID)
                                    let homeTeam = try? objectContext.existingObjectOrNew(predicate: homeTeamPredicate) as Team
                                    if homeTeam?.abbreviation == nil {
                                        homeTeam?.teamID = Int32(homeTeamID)
                                        self.updateTeam(id: homeTeamID)
                                    }
                                    game.homeTeam = homeTeam
                                    
                                    let awayTeamID = gameData.teams.away.team.id
                                    let awayTeamPredicate = Team.fetchPredicate(teamID: awayTeamID)
                                    let awayTeam = try? objectContext.existingObjectOrNew(predicate: awayTeamPredicate) as Team
                                    if awayTeam?.abbreviation == nil {
                                        awayTeam?.teamID = Int32(awayTeamID)
                                        self.updateTeam(id: awayTeamID)
                                    }
                                    game.awayTeam = awayTeam
                                }
                        }
                }
            }
            .store(in: &cancellables)
    }
    
    private var teamsStarted = 0
    private var teamsReceived = 0
    
    private func updateTeam(id: Int) {
//        teamsStarted += 1
//        print("Started \(teamsStarted)")
        NetworkManager.shared.publisher(for: TeamRequest(teamID: id))
            .receive(on: fetchQueue)
            .sink(receiveCompletion: { _ in }, receiveValue: { teamsResponse in
//                self.teamsReceived += 1
//                print("Received \(self.teamsReceived)")
                PersistenceManager.shared.persistOnBackground { objectContext in
                    teamsResponse.teams.forEach { teamResponse in
                        let teamPredicate = Team.fetchPredicate(teamID: teamResponse.id)
                        guard let team = try? objectContext.existingObjectOrNew(predicate: teamPredicate) as Team else {
                            return
                        }
                        team.teamID = Int32(teamResponse.id)
                        team.abbreviation = teamResponse.abbreviation
                        team.name = teamResponse.name
                        team.teamName = teamResponse.teamName
                        team.locationName = teamResponse.locationName
                    }
                }
            })
            .store(in: &cancellables)
    }
    
}
