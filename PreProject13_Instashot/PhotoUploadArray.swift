//
//  PhotoUploadArray.swift
//  PreProject13_Instashot
//
//  Created by Bruno Oliveira on 13/09/24.
//

import PhotosUI
import SwiftUI

struct PhotoUploadArray: View {
    @State private var pickerItems = [PhotosPickerItem]()
    @State private var selectedImages = [Image]()
    
    var body: some View {
        VStack {
            // non limitted photos
            PhotosPicker("Select an Image", selection: $pickerItems, matching: .images)
                .padding()
            
            //limiting the number of photos to upload
            PhotosPicker("Select images", selection: $pickerItems, maxSelectionCount: 3, matching: .images)
                .padding()
            
            //custom label on photosPicker
            PhotosPicker(selection: $pickerItems, maxSelectionCount: 4, matching: .images) {
                Label("Select some pictures", systemImage: "photo")
            }
            .padding()
            
            //And the last way is to limit the kinds of pictures that can be imported. We've used .images here across the board, which means we'll get regular photos, screenshots, panoramas, and more. You can apply a more advanced filter using .any(), .all(), and .not(), and passing them an array. For example, this matches all images except screenshots:
            
            PhotosPicker(selection: $pickerItems, maxSelectionCount: 2, matching: .any(of: [.images, .not(.screenshots)])) {
                Label("Select 2 Images, except screenShots", systemImage: "photo")
            }
            .padding()
            
        }
        .padding()
        .onChange(of: pickerItems) {
            Task {
                selectedImages.removeAll()
                
                for item in pickerItems {
                    if let loadedImage = try await item.loadTransferable(type: Image.self) {
                        selectedImages.append(loadedImage)
                    }
                }
            }
        }
        
        ScrollView {
            ForEach(0..<selectedImages.count, id: \.self) { i in
                selectedImages[i]
                    .resizable()
                    .scaledToFit()
            }
        }
    }
}

#Preview {
    PhotoUploadArray()
}
