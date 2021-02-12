//
//  GamePeriodExt.swift
//  Bar Down
//
//  Created by Alex King on 2/10/20.
//  Copyright © 2020 Pryanik. All rights reserved.
//

import Foundation

extension GamePeriod {
    
    static func predicate(game: Game) -> NSPredicate {
        return NSPredicate(format: "game = %@", game)
    }
    
}

extension GamePeriod {
    public var id: Int {
        return Int(periodNumber)
    }
}
