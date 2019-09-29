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
    case idontevenknow = 5
    case final = 6
    case reallyFinal = 7
}
