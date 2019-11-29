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
    @Published private var teamIDtoUpdate: Int = 0
    private var cancellables = Set<AnyCancellable>()
    
    private var updateDelayCancellable: AnyCancellable?
    private let updateDelayProducer: AnyPublisher<Void, Never> = {
        return Just(()).delay(for: 5, tolerance: nil, scheduler: DispatchQueue.main, options: nil).eraseToAnyPublisher()
    }()
    
    private init() {
    }

    public func beginUpdatingLiveScores() {
        fetchSchedule(date: Date())
        updateScoresAfterDelay()
    }
    
    public func endUpdatingLiveScores() {
        updateDelayCancellable?.cancel()
        cancellables.removeAll()
    }
    
    private func updateScoresAfterDelay() {
        updateDelayCancellable?.cancel()
        updateDelayCancellable = updateDelayProducer.sink(receiveValue: { [weak self] _ in
            guard let self = self else { return }
            self.fetchSchedule(date: Date())
            self.updateScoresAfterDelay()
        })
    }
    
    private func fetchGameDetails(gamePk: Int) {
        NetworkManager.shared.publisher(for: GameRequest(gameID: gamePk))
            .receive(on: fetchQueue)
            .sink(receiveCompletion: { _ in }, receiveValue: { gameDetailsResponse in
//                print(response.gameData.datetime)
                PersistenceManager.shared.persistOnBackground { context in
                    let gameFetchRequest: NSFetchRequest<Game> = Game.fetchRequest()
                    gameFetchRequest.predicate = Game.gameFetchPredicate(gameID: gamePk)
                    guard let game = try? context.fetch(gameFetchRequest).first else {
                        assertionFailure()
                        return
                    }
                    
                    let gameStatus = GameStatus(rawValue: Int(gameDetailsResponse.gameData.status.codedGameState) ?? 0)
                    game.gameStatus = Int32(gameStatus?.rawValue ?? 0)
                    game.sortStatus = Int32(gameStatus?.sortStatus ?? 0)
                }
            })
            .store(in: &cancellables)
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
                                    
//                                    self.fetchGameDetails(gamePk: gameData.gamePk)
                                    
                                    let gameStatus = GameStatus(rawValue: Int(gameData.status.codedGameState) ?? 0)
                                    game.gameStatus = Int32(gameStatus?.rawValue ?? 0)
                                    game.sortStatus = Int32(gameStatus?.sortStatus ?? 0)
                                    
                                    game.apply(linescoreResponse: gameData.linescore)
                                    
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

    private func updateTeam(id: Int) {
        NetworkManager.shared.publisher(for: TeamRequest(teamID: id))
            .receive(on: fetchQueue)
            .sink(receiveCompletion: { _ in }, receiveValue: { teamsResponse in
                PersistenceManager.shared.persistOnBackground { objectContext in
                    teamsResponse.teams.forEach { teamResponse in
                        let teamPredicate = Team.fetchPredicate(teamID: teamResponse.id)
                        guard let team = try? objectContext.existingObjectOrNew(predicate: teamPredicate) as Team else {
                            assertionFailure("Unable to find team with id: \(teamResponse.id)")
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

fileprivate extension Game {
    
    func apply(linescoreResponse: LinescoreResponse) {
        homeTeamGoals = Int32(linescoreResponse.teams.home.goals)
        awayTeamGoals = Int32(linescoreResponse.teams.away.goals)
        clockString = linescoreResponse.currentPeriodTimeRemaining
    }
}
