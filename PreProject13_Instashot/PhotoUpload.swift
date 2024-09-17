//
//  PhotoUpload.swift
//  PreProject13_Instashot
//
//  Created by Bruno Oliveira on 13/09/24.
//

import PhotosUI
import SwiftUI

//SwiftUI's PhotosPicker view provides us with a simple way to import one or more photos from the user's photo library. To avoid causing any performance hiccups, the data gets provided to us as a special type called PhotosPickerItem, which we can then load asynchronously to convert the data into a SwiftUI image

struct PhotoUpload: View {
    //create two properties: one to store the item that was selected, and one to store that selected item as a SwiftUI image
    
    @State private var pickerItem: PhotosPickerItem?
    @State private var selectedImage: Image?
    
    var body: some View {
          
        //add a PhotosPicker view somewhere in your SwiftUI view hierarchy. This must be created with a title to show the user, a binding where to store the selected image, and also what type of data to show – that last part allows us use PhotosPicker to load videos, Live Photos, and more
        
        VStack {
            PhotosPicker("Select a picture", selection: $pickerItem, matching: .images)
            
            //Show the loaded image
            
            selectedImage?
                .resizable()
                .scaledToFit()
        }
        
        //watch pickerItem for changes, because when it changes it means the user has selected a picture for us to load. Once that's done, we can call loadTransferable(type:) on the picker item, which is a method that tells SwiftUI we want to load actual underlying data from the picker item into a SwiftUI image. If that succeeds, we can assign the resulting value to the selectedImage property.
        .onChange(of: pickerItem) {
            Task {
                selectedImage = try await pickerItem?.loadTransferable(type: Image.self)
            }
        }
        
    }
}

#Preview {
    PhotoUpload()
}
