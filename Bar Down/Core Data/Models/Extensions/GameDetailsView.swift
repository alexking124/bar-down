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
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: true) {
            VStack(alignment: .center, spacing: 0) {
                GameDetailsSectionHeader(title: "Shots: \(game.awayTeamShots) - \(game.homeTeamShots)")
                ShotCounterView(game: game)
                GameDetailsSectionHeader(title: "Goals: \(game.awayTeamGoals) - \(game.homeTeamGoals)")
                GoalListView(game: game).background(Color.green)
            }
            .frame(width: UIScreen.main.bounds.width, alignment: .topLeading)
        }.onAppear {
            NetworkDispatch.shared.fetchGameDetails(gamePk: Int(self.game.gameID))
        }
        .navigationBarTitle("\(game.awayTeam?.abbreviation ?? "") @ \(game.homeTeam?.abbreviation ?? "")")
    }
}
