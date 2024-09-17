//
//  UnavailableViewSimple.swift
//  PreProject13_Instashot
//
//  Created by Bruno Oliveira on 13/09/24.
//

import SwiftUI

struct UnavailableViewSimple: View {
    var body: some View {
        //SwiftUI's ContentUnavailableView shows a standard user interface for when your app has nothing to display like a result of a search or things that hasn`t been provied yet

        ContentUnavailableView("No Snippets", systemImage: "swift")
    }
}

#Preview {
    UnavailableViewSimple()
}
