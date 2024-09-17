//
//  RequestingAnAppReview.swift
//  PreProject13_Instashot
//
//  Created by Bruno Oliveira on 17/09/24.
//

//SwiftUI provides a special environment key called .requestReview, which lets us ask the user to leave a review for our app on the App Store. Apple takes care of showing the whole user interface, making sure it doesn't get shown if the user has already left a review, and also limiting how often the request can be shown – we just need to make a request when we're ready

//This process takes three steps, starting with a new import for StoreKit
import StoreKit
import SwiftUI

struct RequestingAnAppReview: View {
    //Second, you need to add a property to read the review requester from SwiftUI's environment:
    @Environment(\.requestReview) var requestReview
    
    var body: some View {
       //And third, you need to request a review when you're ready. When you're just starting out, you might think attaching the review to a button press is a good idea, like this:
        Button("Leave a Review!") {
            requestReview()
        }
    }
}

//However, that's far from ideal, not least because we're only requesting that a review prompt be shown – the user might have disabled these alerts system-wide, or they might already have reached the maximum number of review requests allowed, in which case your button would do nothing. Instead, it's better to call requestReview() automatically when you think it's the right time. A good starting place is when the user has performed an important task some number of times, because that way it's clear they have realized the benefit of your app.

#Preview {
    RequestingAnAppReview()
}

