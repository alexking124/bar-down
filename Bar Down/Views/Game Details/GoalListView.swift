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

    private var fetchRequest: FetchRequest<GameEvent>
    private var fetchedResults: FetchedResults<GameEvent> {
        fetchRequest.wrappedValue
    }

    private var groupedResults: [Int: [GameEvent]] {
        Dictionary(grouping: fetchedResults, by: { Int($0.periodNumber) })
    }

    init(gameID: Int32) {
        fetchRequest = FetchRequest(sortDescriptors: [NSSortDescriptor(key: "eventIndex", ascending: true)],
                                    predicate: GameEvent.predicate(gameID: gameID, eventType: .goal))
    }
    
    var body: some View {
        if fetchedResults.count > 0 {
            VStack(alignment: .leading, spacing: 4) {
                ForEach(fetchedResults) {
                    GoalScoredView(goalEvent: $0)
                }
            }.padding()
        } else {
            Text("No Goals").padding()
        }
    }
}

fileprivate struct GoalScoredView: View {
    
    @ObservedObject private var goalEvent: GameEvent
    
    init(goalEvent: GameEvent) {
        self.goalEvent = goalEvent
    }
    
    var body: some View {
        HStack(alignment: .top) {
            Image(goalEvent.nhlTeamID.imageName).resizable().scaledToFit().frame(width: 35, height: 35, alignment: .top)
            VStack(alignment: .leading, spacing: 2) {
                HStack {
                    Text("\(goalEvent.periodTime ?? "") \(goalEvent.periodOrdinal ?? "")").font(Font.system(size: 14))
                    if let strength = goalEvent.strengthCode.map { StrengthCode(code: $0) }, strength != .even {
                        GoalModifierView(modifierText: strength.rawValue)
                    }
                    if goalEvent.emptyNet {
                        GoalModifierView(modifierText: "EN")
                    }
                }
                Text(goalEvent.eventDescription ?? "").font(Font.system(size: 14))
            }
            Spacer()
        }
    }
}

fileprivate struct GoalModifierView: View {

    private let modifierText: String

    init(modifierText: String) {
        self.modifierText = modifierText
    }

    var body: some View {
        Text(modifierText)
            .font(Font.system(size: 11))
            .fontWeight(.bold)
            .padding(8)
            .background(Color.red)
            .frame(height: 20)
            .cornerRadius(10)
    }
}
