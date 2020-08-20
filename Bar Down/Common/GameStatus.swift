//
//  GameStatus.swift
//  Bar Down
//
//  Created by Alex King on 9/27/19.
//  Copyright © 2019 Pryanik. All rights reserved.
//

import Foundation

enum GameStatus: Int {
    case scheduled = 1
    case pregame = 2
    case live = 3
    case critical = 4
    case gameOver = 5
    case final = 6
    case reallyFinal = 7
    case scheduledTBD = 8
    case postponed = 9
    
    var sortStatus: Int {
        switch self {
        case .live: return 0
        case .critical: return 0
        case .pregame: return 1
        case .scheduled: return 1
        case .gameOver: return 2
        case .final: return 2
        case .reallyFinal: return 2
        case .scheduledTBD: return 2
        case .postponed: return 2
        }
    }
    
    var statusText: String {
        switch self {
        case .live: return "Live"
        case .critical: return "Live"
        case .pregame: return "Pregame"
        case .scheduled: return "Scheduled"
        case .gameOver: return "Final"
        case .final: return "Final"
        case .reallyFinal: return "Final"
        case .scheduledTBD: return "Scheduled"
        case .postponed: return "Postponed"
        }
    }
}
