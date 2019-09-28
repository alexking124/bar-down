//
//  TeamExt.swift
//  Bar Down
//
//  Created by Alex King on 9/26/19.
//  Copyright © 2019 Pryanik. All rights reserved.
//

import Foundation
import UIKit
import CoreData

extension Team {
    
    static func fetchRequestForTeam(id: Int) -> NSFetchRequest<Team> {
        let fetchRequest: NSFetchRequest<Team> = Team.fetchRequest()
        fetchRequest.predicate = Team.fetchPredicate(teamID: id)
        return fetchRequest
    }
    
    static func fetchPredicate(teamID: Int) -> NSPredicate {
        return NSPredicate(format: "%K = %@", "teamID", "\(teamID)")
    }
    
    var nhlTeamID: NHLTeamID {
        return NHLTeamID(rawValue: Int(teamID)) ?? .nhl
    }
    
    var logo: UIImage? {
        return NHLTeamID.logo(for: nhlTeamID)
    }
    
}
