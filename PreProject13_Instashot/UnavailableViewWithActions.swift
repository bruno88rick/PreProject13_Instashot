//
//  UnavailableViewWithActions.swift
//  PreProject13_Instashot
//
//  Created by Bruno Oliveira on 13/09/24.
//

import SwiftUI

struct UnavailableViewWithActions: View {
    var body: some View {
        ContentUnavailableView {
            Label("No Snippets", systemImage: "swift")
        } description: {
            Text("You don't have snippets created yet!")
        } actions: {
            Button("Create Snippet now!") {
                //create a snippet
            }
            .buttonStyle(.borderedProminent)
        }
    }
}

#Preview {
    UnavailableViewWithActions()
}
