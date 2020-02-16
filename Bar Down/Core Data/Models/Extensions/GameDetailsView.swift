//
//  GameDetailsView.swift
//  Bar Down
//
//  Created by Alex King on 2/1/20.
//  Copyright © 2020 Pryanik. All rights reserved.
//

import Foundation
import SwiftUI
import CoreData
import Combine

struct GameDetailsView: View {
    
    @ObservedObject var game: Game
    
    init(game: Game) {
        self.game = game
    }
    
    var goalsByPeriod: [String] {
        return game.typedPeriods.map { "\($0.ordinalNumber ?? ""): \($0.awayGoals) - \($0.homeGoals)" }
    }
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: true) {
            VStack {
                Text("Shots: \(game.awayTeamShots) - \(game.homeTeamShots)")
                ForEach(goalsByPeriod) {
                    Text($0)
                }
            }
        }.onAppear {
            NetworkDispatch.shared.fetchGameDetails(gamePk: Int(self.game.gameID))
        }
        .navigationBarTitle("\(game.awayTeam?.abbreviation ?? "") @ \(game.homeTeam?.abbreviation ?? "")")
    }
}

extension String: Identifiable {
    public var id: Int {
        return hashValue
    }
}
