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
    
    var hasOvertime: Bool {
        return currentPeriod > 3
    }
    
    var periodString: String {
        switch currentPeriod {
        case 1: return "1st"
        case 2: return "2nd"
        case 3: return "3rd"
        case 4: return "OT"
        default: return "SO"
        }
    }
    
    public var scoreboardPrimaryText: String {
        switch status {
        case .pregame, .scheduled, .postponed:
            return gameTime.map { DateFormatter.scheduledGameTimeFormatter.string(from: $0) } ?? ""
        default:
            return "\(awayTeamGoals) - \(homeTeamGoals)"
        }
    }
    
    public var scoreboardSecondaryText: String {
        switch status {
        case .live, .critical:
            return (clockString ?? "") + " " + periodString
        case .final, .reallyFinal:
            let statusText = status.statusText
            if hasShootout {
                return statusText + " SO"
            } else if hasOvertime {
                return statusText + " OT"
            }
            return statusText
        default:
            return status.statusText
        }
    }
    
    public var typedPeriods: [GamePeriod] {
        return (periods?.allObjects as? [GamePeriod] ?? []).sorted { (periodA, periodB) -> Bool in
            periodA.periodNumber < periodB.periodNumber
        }
    }
    
    public var typedEvents: [GameEvent] {
        return events?.allObjects as? [GameEvent] ?? []
    }
}
