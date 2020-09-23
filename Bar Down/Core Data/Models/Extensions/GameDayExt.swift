//
//  GameDayExt.swift
//  Bar Down
//
//  Created by Alex King on 9/22/19.
//  Copyright © 2019 Pryanik. All rights reserved.
//

import Foundation

extension GameDay {
    
    static func gameDayFetchPredicate(gameDate: String) -> NSPredicate {
        return NSPredicate(format: "%K = %@", "gameDate", "\(gameDate)")
    }
    
    var gameList: [Game] {
        return games?.compactMap { $0 as? Game } ?? []
    }
    
}

extension GameDay {
    public var id: String {
        return gameDate ?? ""
    }
}
