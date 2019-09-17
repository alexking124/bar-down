//
//  ScoreboardTeamView.swift
//  Bar Down
//
//  Created by Alex King on 9/8/19.
//  Copyright © 2019 Pryanik. All rights reserved.
//

import Foundation
import SwiftUI

enum HomeAwayStatus {
    case home
    case away
}

struct ScoreboardTeamView: View {
    
    let homeAwayStatus: HomeAwayStatus
    
    var stackAlignment: HorizontalAlignment {
        switch homeAwayStatus {
        case .home: return .trailing
        case .away: return .leading
        }
    }
    
    var body: some View {
        VStack(alignment: stackAlignment, spacing: 0) {
            Image("sjs")
                .resizable()
                .scaledToFit()
                .frame(width: 84, height: 70)
            Spacer(minLength: 8)
            Text("San Jose")
                .font(Font.system(size: 11, weight: .semibold, design: .default))
            Text("Sharks")
                .font(Font.system(size: 15, weight: .light, design: .default))
        }
    }
}
