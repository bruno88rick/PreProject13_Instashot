//
//  SwiftUIView.swift
//  PreProject13_Instashot
//
//  Created by Bruno Oliveira on 17/09/24.
//

import SwiftUI

struct Share_Link: View {
    var body: some View {
        //we can share a URL like this:
        ShareLink(item: URL(string: "https://www.hacingwithswift.com")!)
        
        //If you want more control over the data, you have several options. First, you can attach a subject and message to the shared data like this:
        ShareLink(item: URL(string: "https://www.hackingwithswift.com")!, subject: Text("Learn Swift Here"), message: Text("Check out the 100 Days of SwiftUI"))
        //How that information is used depends on the app users share to – the URL will always be attached, because that's the most important thing, but some apps will use the subject, some the message, and others will use both
        
        
        //Second, you can customize the button itself by providing whatever label you want:
        ShareLink(item: URL(string: "https://www.hackingwithswift.com")!) {
            Label("Spread The Word about Swift", systemImage: "swift")
        }
        
        
        //And third, you can provide a preview to attach, which is important when you're sharing something more complex – it's possible to share entirely custom data here, so the preview is helpful for giving the recipient some idea of what's inside. Annoyingly, this is needed even for data that is its own preview, such as an image. To avoid making your code repetitive, I'd suggest assigning the image to a local constant then using that:
        let example = Image(.example)
        
        ShareLink(item: example, preview: SharePreview("Vacation on Caldas Novas-GO - Brazil", image: example)) {
            Label("Click to share the image", systemImage: "airplane")
        }
        
    }
}

#Preview {
    Share_Link()
}
