//
//  ScoreboardScoreView.swift
//  Bar Down
//
//  Created by Alex King on 9/28/19.
//  Copyright © 2019 Pryanik. All rights reserved.
//

import Foundation
import SwiftUI

struct ScoreboardScoreView: View {
    
    let score: String
    let gameStatus: String
    
    init(score: String, gameStatus: String) {
        self.score = score
        self.gameStatus = gameStatus
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 2) {
            Text(score).font(.system(size: 18, weight: .medium))
            Text(gameStatus).font(.system(size: 14, weight: .light))
        }
    }
}
