//
//  PenaltyListView.swift
//  Bar Down
//
//  Created by Alex King on 1/28/21.
//  Copyright © 2021 Pryanik. All rights reserved.
//

import Foundation
import SwiftUI

struct PenaltyListView: View {

  private var fetchRequest: FetchRequest<GameEvent>
  private var fetchedResults: FetchedResults<GameEvent> {
      fetchRequest.wrappedValue
  }

  init(gameID: Int32) {
    fetchRequest = FetchRequest(sortDescriptors: [NSSortDescriptor(key: "eventIndex", ascending: true)],
                                predicate: GameEvent.predicate(gameID: gameID, eventType: .penalty))
  }

  var body: some View {
    if fetchedResults.count > 0 {
      VStack(alignment: .leading, spacing: 4) {
        ForEach(fetchedResults) { penalty in
                HStack(alignment: .top) {
                  Image((NHLTeamID(rawValue: Int(penalty.teamID)) ?? .nhl).imageName).resizable().scaledToFit().frame(width: 35, height: 35, alignment: .top)
                    VStack(alignment: .leading, spacing: 2) {
                      Text("\(penalty.periodTime ?? "") \(penalty.periodOrdinal ?? "")")
                        .font(Font.system(size: 14))
                      Text(penalty.eventDescription ?? "")
                        .font(Font.system(size: 14))
                        .fixedSize(horizontal: false, vertical: true)
                    }
                      Spacer()
                  }
        }
      }.padding()
    } else {
      Text("No Penalties").padding()
    }
  }
}
