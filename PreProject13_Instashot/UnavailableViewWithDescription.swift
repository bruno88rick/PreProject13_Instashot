//
//  UnavailableViewWithDescription.swift
//  PreProject13_Instashot
//
//  Created by Bruno Oliveira on 13/09/24.
//

import SwiftUI

struct UnavailableViewWithDescription: View {
    var body: some View {
        ContentUnavailableView("No Snippets", systemImage: "swift", description: Text("You don't have any snippets yet."))
    }
}

#Preview {
    UnavailableViewWithDescription()
}
