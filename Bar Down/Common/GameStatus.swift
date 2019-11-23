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
    case iDontEvenKnow = 5
    case final = 6
    case reallyFinal = 7
    
    var sortStatus: Int {
        switch self {
        case .live: return 0
        case .critical: return 0
        case .pregame: return 1
        case .scheduled: return 1
        case .final: return 2
        case .reallyFinal: return 2
        case .iDontEvenKnow: return 3
        }
    }
}
