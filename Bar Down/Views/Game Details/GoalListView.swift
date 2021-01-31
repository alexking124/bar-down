//
//  GoalListView.swift
//  Bar Down
//
//  Created by Alex King on 3/7/20.
//  Copyright © 2020 Pryanik. All rights reserved.
//

import Foundation
import SwiftUI

struct GoalListView: View {

  private var fetchRequest: FetchRequest<GameEvent>
  private var fetchedResults: FetchedResults<GameEvent> {
      fetchRequest.wrappedValue
  }

  init(gameID: Int32) {
    fetchRequest = FetchRequest(sortDescriptors: [NSSortDescriptor(key: "eventIdentifier", ascending: true)],
                                predicate: GameEvent.predicate(gameID: gameID, eventType: .goal))
  }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            ForEach(fetchedResults) { goalEvent in
              GoalScoredView(description: goalEvent.eventDescription ?? "", teamID: goalEvent.teamID)
            }
        }.padding()
    }
}

fileprivate struct GoalScoredView: View {
    
    private let description: String
    private let teamID: NHLTeamID
    
    init(description: String, teamID: Int32) {
        self.description = description
        self.teamID = NHLTeamID(rawValue: Int(teamID)) ?? .nhl
    }
    
    var body: some View {
        HStack {
            Image(teamID.imageName).resizable().scaledToFit().frame(width: 35, height: 35, alignment: .center)
            Text(description)
                .font(Font.system(size: 14))
            Spacer()
        }
    }
}
