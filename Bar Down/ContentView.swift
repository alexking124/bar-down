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
        fetchRequest = FetchRequest(sortDescriptors: [NSSortDescriptor(key: "gameTime", ascending: true),
                                                      NSSortDescriptor(key: "sortStatus", ascending: true)],
                                    predicate: Game.fetchPredicateFor(date: date))
    }
    
    var body: some View {
        return List(fetchedResults) { game in
            HStack {
                ScoreboardTeamView(homeAwayStatus: .away, teamID: Int(game.awayTeam?.teamID ?? 0))
                Spacer()
                ScoreboardTeamView(homeAwayStatus: .home, teamID: Int(game.homeTeam?.teamID ?? 0))
            }.padding(EdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 4))
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
