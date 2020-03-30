//
//  GoalListView.swift
//  Bar Down
//
//  Created by Alex King on 3/7/20.
//  Copyright © 2020 Pryanik. All rights reserved.
//

import Foundation
import SwiftUI

struct GoalListView: View {
    
    @ObservedObject var game: Game
    
    init(game: Game) {
        self.game = game
    }
    
    private var goalEvents: [GameEvent] { game.typedEvents.filter({ $0.eventTypeId == "GOAL" }) }
    private var goalDescriptions: [(String, Int32)] { goalEvents.map({ ($0.eventDescription ?? "", $0.teamID) }) }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            ForEach(goalDescriptions, id: \.0.self) { description in
                GoalScoredView(description: description.0, teamID: description.1)
            }
        }.padding()
    }

}

fileprivate struct GoalScoredView: View {
    
    private let description: String
    private let teamID: NHLTeamID
    
    init(description: String, teamID: Int32) {
        self.description = description
        self.teamID = NHLTeamID(rawValue: Int(teamID)) ?? .nhl
    }
    
    var body: some View {
        HStack {
            Image(teamID.imageName).resizable().scaledToFit().frame(width: 35, height: 35, alignment: .center)
            Text(description)
                .font(Font.system(size: 14))
            Spacer()
        }
    }
}
