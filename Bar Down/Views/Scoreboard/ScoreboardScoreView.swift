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
    
    init(score: String) {
        self.score = score
    }
    
    var body: some View {
        VStack {
            Text(score)
        }
    }
}
