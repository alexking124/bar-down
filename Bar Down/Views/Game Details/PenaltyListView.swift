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
    fetchRequest = FetchRequest(sortDescriptors: [NSSortDescriptor(key: "eventIdentifier", ascending: true)],
                                predicate: GameEvent.predicate(gameID: gameID, eventType: .penalty))
  }

  var body: some View {
    if fetchedResults.count > 0 {
      VStack(alignment: .leading, spacing: 2) {
        ForEach(fetchedResults) { penalty in
          Text(penalty.eventDescription ?? "").font(Font.system(size: 14))
        }
      }.padding()
    } else {
      Text("No Penalties")
    }
  }
}
