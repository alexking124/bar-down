//
//  ContentView.swift
//  Bar Down
//
//  Created by Alex King on 8/11/19.
//  Copyright © 2019 Pryanik. All rights reserved.
//

import SwiftUI
import CoreData
import Combine

struct ContentView: View {
    
    private var fetchRequest: FetchRequest<Game>
    private var fetchedResults: FetchedResults<Game> {
        fetchRequest.wrappedValue
    }
    
    private let date: Date
    
    init(date: Date) {
        self.date = date
        fetchRequest = FetchRequest(sortDescriptors: [NSSortDescriptor(key: "gameTime", ascending: true)],
                                    predicate: Game.fetchPredicateFor(date: date))
    }
    
    var body: some View {
        return List(fetchedResults) { game in
            HStack {
                ScoreboardTeamView(team: game.awayTeam!, homeAwayStatus: .away)
                Spacer()
                ScoreboardTeamView(team: game.homeTeam!, homeAwayStatus: .home)
            }
        }
    }
}

//#if DEBUG
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView(date: GameDay())
//    }
//}
//#endif
