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

  @Environment(\.managedObjectContext) var managedObjectContext
    
    private var fetchRequest: FetchRequest<Game>
    private var fetchedResults: FetchedResults<Game> {
        fetchRequest.wrappedValue
    }
    
    private let date: Date
    
    init(date: Date) {
        self.date = date
        fetchRequest = FetchRequest(sortDescriptors: [NSSortDescriptor(key: "sortStatus", ascending: true),
                                                      NSSortDescriptor(key: "gameTime", ascending: true),
                                                      NSSortDescriptor(key: "gameID", ascending: true)],
                                    predicate: Game.fetchPredicateFor(date: date))
    }
    
    var body: some View {
        ScrollView(.vertical) {
            VStack {
                ForEach(fetchedResults) { game in
                    if game.gameDetailsEnabled {
                        NavigationLink(destination: GameDetailsView(game: game).environment(\.managedObjectContext, managedObjectContext)) {
                            ScoreboardGameSummaryView(game: game)
                        }.buttonStyle(.plain)
                    } else {
                        ScoreboardGameSummaryView(game: game)
                    }
                }
            }.padding()
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
