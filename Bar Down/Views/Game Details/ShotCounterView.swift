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
    
    @ObservedObject var game: Game
    
    init(game: Game) {
        self.game = game
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Shots").font(Font.system(size: 24))
                ForEach(0..<max(3, game.typedPeriods.count), id: \.self) { periodNumber in
                    return Text("\(self.game.typedPeriods[safe: periodNumber]?.ordinalNumber ?? "-")")
                }
                if game.hasShootout {
                    Text("SO")
                }
            }.padding()
            Spacer()
        }
    }
    
}

private struct ShotCounterRow: View {
    var body: some View {
        Text("Shots")
    }
}
