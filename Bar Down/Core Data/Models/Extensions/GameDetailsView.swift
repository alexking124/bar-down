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
            VStack(alignment: .center) {
                GameDetailsSectionHeader(title: "Shots: \(game.awayTeamShots) - \(game.homeTeamShots)")
                ShotCounterView(game: game)
            }
            .frame(width: UIScreen.main.bounds.width, alignment: .topLeading)
        }.onAppear {
            NetworkDispatch.shared.fetchGameDetails(gamePk: Int(self.game.gameID))
        }
        .navigationBarTitle("\(game.awayTeam?.abbreviation ?? "") @ \(game.homeTeam?.abbreviation ?? "")")
    }
}

extension View {
    func fillParent(alignment: Alignment = .center) -> some View {
        return GeometryReader { geometry in
            self.frame(width: geometry.size.width,
                       height: geometry.size.height,
                       alignment: alignment)
        }
    }
}

extension String: Identifiable {
    public var id: Int {
        return hashValue
    }
}
