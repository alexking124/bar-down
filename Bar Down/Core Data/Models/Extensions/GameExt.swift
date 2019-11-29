//
//  GameExt.swift
//  Bar Down
//
//  Created by Alex King on 9/22/19.
//  Copyright © 2019 Pryanik. All rights reserved.
//

import Foundation

extension Game {
    static func gameFetchPredicate(gameID: Int) -> NSPredicate {
        return NSPredicate(format: "%K = %@", "gameID", "\(gameID)")
    }
    
    static func fetchPredicateFor(date: Date) -> NSPredicate {
        var calendar = Calendar.current
        calendar.timeZone = NSTimeZone.local
        let dateFrom = calendar.startOfDay(for: date)
        let dateTo = calendar.date(byAdding: .day, value: 1, to: dateFrom) ?? Date()

        let fromPredicate = NSPredicate(format: "%K >= %@", "gameTime", dateFrom as NSDate)
        let toPredicate = NSPredicate(format: "%K < %@", "gameTime", dateTo as NSDate)
        return NSCompoundPredicate(andPredicateWithSubpredicates: [fromPredicate, toPredicate])
    }
}

extension Game: Identifiable {
    public var id: Int {
        return Int(gameID)
    }
}

extension Game {
    var status: GameStatus {
        return GameStatus(rawValue: Int(gameStatus)) ?? .scheduled
    }
    
//    public var scoreboardPrimaryText: String {
//        switch status {
//        case .scheduled, .pregame:
//            return status.statusText
//            case
//        }
//    }
}
