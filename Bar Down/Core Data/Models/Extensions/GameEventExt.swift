//
//  GameEventExt.swift
//  Bar Down
//
//  Created by Alex King on 3/7/20.
//  Copyright © 2020 Pryanik. All rights reserved.
//

import Foundation

extension GameEvent {

    static func predicate(gameID: Int32, eventType: GameEventType) -> NSPredicate {
        return NSPredicate(format: "(%K BEGINSWITH %@) AND (%K = %@)", "eventIdentifier", "\(gameID)", "eventTypeId", eventType.rawValue)
    }

    static func gameEventFetchPredicate(gameEventID: String) -> NSPredicate {
        return NSPredicate(format: "%K = %@", "eventIdentifier", "\(gameEventID)")
    }
    
    func apply(response: GamePlayResponse) {
        eventDescription = response.result.description
        eventTypeId = response.result.eventTypeId
        teamID = Int32(response.team?.id ?? 0)
        strengthCode = response.result.strength?.code
        periodTime = response.about.periodTime
        periodNumber = Int32(response.about.period)
        eventIndex = Int32(response.about.eventIdx)
        periodOrdinal = response.about.ordinalNum
        emptyNet = response.result.emptyNet ?? false
        secondaryType = response.result.secondaryType
        gameWinningGoal = response.result.gameWinningGoal ?? false
        penaltyMinutes = Int32(response.result.penaltyMinutes ?? 0)
        penaltySeverity = response.result.penaltySeverity
    }

}

extension GameEvent {
    public var id: String {
        return eventIdentifier ?? ""
    }

    var nhlTeamID: NHLTeamID {
        NHLTeamID(rawValue: Int(teamID)) ?? .nhl
    }
}
