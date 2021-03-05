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
            ShotCounterColumnView(columnTitle: " ", homeText: game.homeTeam?.abbreviation ?? "", awayText: game.awayTeam?.abbreviation ?? "")
            Spacer()
            ForEach(0..<max(3, fetchRequest.wrappedValue.count), id: \.self) { periodIndex -> ShotCounterColumnView in
                let title: String
                if periodIndex < 3 {
                    title = NumberFormatter.ordinalFormatter.string(from: NSNumber(value: periodIndex+1)) ?? " "
                } else if periodIndex == 3 {
                    title = "OT"
                } else {
                    title = "\(periodIndex-2)OT"
                }
                if let gamePeriod = fetchRequest.wrappedValue[safe: periodIndex] {
                    return ShotCounterColumnView(columnTitle: title,
                                                 homeText: "\(gamePeriod.homeShots)",
                                                 awayText: "\(gamePeriod.awayShots)")
                } else {
                    return ShotCounterColumnView(columnTitle: title, homeText: "-", awayText: "-")
                }
            }
            ShotCounterColumnView(columnTitle: "T", homeText: "\(game.homeTeamShots)", awayText: "\(game.awayTeamShots)")
                .padding(.leading, 6)
        }.padding()
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
            Text(awayText)
            Text(homeText)
        }
    }
}
