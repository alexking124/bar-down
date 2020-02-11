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
            VStack {
                Text("\(game.awayTeam?.abbreviation ?? "") @ \(game.homeTeam?.abbreviation ?? "")")
                Text("Shots: \(game.awayTeamShots) - \(game.homeTeamShots)")
            }
        }.onAppear {
            NetworkDispatch.shared.fetchGameDetails(gamePk: Int(self.game.gameID))
        }
    }
}
