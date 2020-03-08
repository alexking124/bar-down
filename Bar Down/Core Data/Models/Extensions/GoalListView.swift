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
    private var goalDescriptions: [String] { goalEvents.compactMap({$0.eventDescription}) }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            ForEach(goalDescriptions, id: \.self) { description in
                Text(description)
                    .font(Font.system(size: 14))
            }
        }.padding()
    }
    
}
