//
//  ShotCounterView.swift
//  Bar Down
//
//  Created by Alex King on 2/16/20.
//  Copyright © 2020 Pryanik. All rights reserved.
//

import Foundation
import SwiftUI

struct ShotCounterView: View {
    
    private var game: Game
    private var fetchRequest: FetchRequest<GamePeriod>
    
    init(game: Game) {
        self.game = game
        fetchRequest = FetchRequest(sortDescriptors: [NSSortDescriptor(key: "periodNumber", ascending: true)],
                                    predicate: GamePeriod.predicate(game: game))
    }
    
    var body: some View {
        HStack {
            ShotCounterColumnView(columnTitle: "", homeText: game.homeTeam?.abbreviation ?? "", awayText: game.awayTeam?.abbreviation ?? "")
            VStack(alignment: .leading) {
                ForEach(0..<max(3, fetchRequest.wrappedValue.count), id: \.self) { periodNumber in
                    return Text("\(fetchRequest.wrappedValue[safe: periodNumber]?.ordinalNumber ?? "-")")
                }
                if game.hasShootout {
                    Text("SO")
                }
            }.padding()
            Spacer()
        }
    }
    
}

fileprivate struct ShotCounterColumnView: View {

    private let columnTitle: String
    private let homeText: String
    private let awayText: String

    fileprivate init(columnTitle: String, homeText: String, awayText: String) {
        self.columnTitle = columnTitle
        self.homeText = homeText
        self.awayText = awayText
    }

    var body: some View {
        VStack {
            Text(columnTitle)
                .fontWeight(.semibold)
            Text(homeText)
            Text(awayText)
        }
    }
}
