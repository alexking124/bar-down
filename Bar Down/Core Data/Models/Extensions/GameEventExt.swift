//
//  GameEventExt.swift
//  Bar Down
//
//  Created by Alex King on 3/7/20.
//  Copyright © 2020 Pryanik. All rights reserved.
//

import Foundation

extension GameEvent {

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
    }

}

extension GameEvent: Identifiable {
    public var id: String {
        return eventIdentifier ?? ""
    }
}
