//
//  CoreImageAndSwiftUI.swift
//  PreProject13_Instashot
//
//  Created by Bruno Oliveira on 12/09/24.
//

import CoreImage
import CoreImage.CIFilterBuiltins
import SwiftUI

struct CoreImageAndSwiftUI: View {
    @State private var image: Image?
    @State private var image2: Image?
    @State private var image3: Image?
    @State private var image4: Image?
    @State private var imageWithDynamicallyFilterValue: Image?
    
    var body: some View {
        VStack {
            image?
                .resizable()
                .scaledToFit()
                .padding()
        
            image2?
                .resizable()
                .scaledToFit()
                .padding()
            
            image3?
                .resizable()
                .scaledToFit()
                .padding()
            
            image4?
                .resizable()
                .scaledToFit()
                .padding()
            
            imageWithDynamicallyFilterValue?
                .resizable()
                .scaledToFit()
                .padding()
        }
        .onAppear(perform: loadImageUI)
    }
    
    //function to load an image in SwiftUI
    func loadImage() {
        image = Image(.example)
        image2 = Image(.example)
    }
    
    //function to load an image in UIImage
    func loadImageUI() {
        
        //loading example image into a UIImage and converting that into a CIImage, which is what core Image wants do work witch
        let inputImage = UIImage(resource: .example)
        let beginImage = CIImage(image: inputImage)
        
        //creating a Core Image context and a Core Image Filter
        //Filters are the things that do the actual work of transforming image data somehow, such as blurring it, sharpening it, adjusting the colors, and so on, and contexts handle converting that processed data into a CGImage we can work with. We need to import CoreImage framework and CIFiltersBuiltins to our projec.
        
        let context = CIContext()
        let currentFilter = CIFilter.sepiaTone()
        
        // customizing the filter and applying to the inputImage
        
        currentFilter.inputImage = beginImage
        currentFilter.intensity = 1
        
        //convert the output from our filter to a SwiftUI Image that we can display in our view
        /*
         1- Read the output image from our filter, which will be a CIImage. This might fail, so it returns an optional.
         2- Ask our context to create a CGImage from that output image. This also might fail, so again it returns an optional.
         3- Convert that CGImage into a UIImage.
         4- Convert that UIImage into a SwiftUI Image.
         
         You can go direct from a CGImage to a SwiftUI Image but it requires extra parameters and it just adds even more complexity!
         */
        
        // get a CIImage from our filter or exit if that fails
        guard let outputImage = currentFilter.outputImage else { return }
        
        // attempt to get a CGImage from our CIImage
        guard let cgImage = context.createCGImage(outputImage, from: outputImage.extent) else { return }
        
        // convert that to a UIImage
        let uiImage = UIImage(cgImage: cgImage)
        
        // and convert that to a SwiftUI image
        image = Image(uiImage: uiImage)
        
        
        //WE CAN LOAD OTHERS CIFILTER TOO LIKE: PIXELLATE
        
        let inputImage2 = UIImage(resource: .example)
        let beginImage2 = CIImage(image: inputImage2)
        
        let context2 = CIContext()
        let currentFilter2 = CIFilter.pixellate()
        
        currentFilter2.inputImage = beginImage2
        currentFilter2.scale = 100
        
        guard let outputImage2 = currentFilter2.outputImage else { return }
        
        guard let cgImage2 = context2.createCGImage(outputImage2, from: outputImage2.extent) else { return }
    
        let uiImage2 = UIImage(cgImage: cgImage2)
        
        image2 = Image(uiImage: uiImage2)
        
        //OR WE CAN LOAD CRYSTALLIZE
        
        let inputImage3 = UIImage(resource: .example)
        let beginImage3 = CIImage(image: inputImage3)
        
        let context3 = CIContext()
        let currentFilter3 = CIFilter.crystallize()
        
        currentFilter3.inputImage = beginImage3
        currentFilter3.radius = 200
        
        guard let outputImage3 = currentFilter3.outputImage else { return }
        
        guard let cgImage3 = context3.createCGImage(outputImage3, from: outputImage3.extent) else { return }
        
        let uiImage3 = UIImage(cgImage: cgImage3)
        
        image3 = Image(uiImage: uiImage3)
        
        
        // OR WE CAN LOAD twirDistortion
        
        let inputImage4 = UIImage(resource: .example)
        let beginImage4 = CIImage(image: inputImage4)
        
        let context4 = CIContext()
        let currentFilter4 = CIFilter.twirlDistortion()
        
        currentFilter4.inputImage = beginImage4
        currentFilter4.angle = 1000
        currentFilter4.center = CGPoint(x: inputImage4.size.width / 2, y: inputImage4.size.height / 2)
        
        guard let outputImage4 = currentFilter4.outputImage else { return }
        
        guard let cgImage4 = context4.createCGImage(outputImage4, from: outputImage4.extent) else { return }
        
        let uiImage4 = UIImage(cgImage: cgImage4)
        
        image4 = Image(uiImage: uiImage4)
        
        //So, there’s a lot we can do using only the modern API. But for this project we’re going to use the older API for setting values such as radius and scale because it lets us set values dynamically – we can literally ask the current filter what values it supports, then send them on in
        
        let inputImageDynamicallyFilter = UIImage(resource: .example)
        let beginImageDynamicallyFilter = CIImage(image: inputImageDynamicallyFilter)
        
        let contextDynamicallyFilter = CIContext()
        let currentFilterDynamicallyFilter = CIFilter.motionBlur()
        currentFilterDynamicallyFilter.inputImage = beginImageDynamicallyFilter
        
        let amount = 1.0
        
        let inputKeys = currentFilterDynamicallyFilter.inputKeys
        
        for key in inputKeys {
            if key == kCIInputRadiusKey {
                currentFilterDynamicallyFilter.setValue(amount * 200, forKey: key)
            }
            if key == kCIInputScaleKey {
                currentFilterDynamicallyFilter.setValue(amount * 10, forKey: key)
            }
            if key == kCIInputIntensityKey {
                currentFilterDynamicallyFilter.setValue(amount, forKey: key)
            }
        }
        
        guard let outputImageDynamicallyFilter = currentFilterDynamicallyFilter.outputImage else { return }
        
        guard let cgImageDynamicallyFilter = contextDynamicallyFilter.createCGImage(outputImageDynamicallyFilter, from: outputImageDynamicallyFilter.extent) else { return }
        
        let uiImageDynamicallyFilter = UIImage(cgImage: cgImageDynamicallyFilter)
       
        imageWithDynamicallyFilterValue = Image(uiImage: uiImageDynamicallyFilter)
        
        /* With that in place, you can now change the twirl distortion to any other filter and the code will carry on working – each of the adjustment values are sent in only if they are supported.
         
         Notice how that relies on setting values for keys, which might remind you of the way UserDefaults works. In fact, all those kCIInput keys are all implemented as strings behind the scenes, so it’s even more similar than you might have realized!

         If you’re implementing precise Core Image adjustments you should definitely be using the newer API that uses exact property names and types, but in this project the older API comes in useful because it lets us send in adjustments regardless of what filter is actually used*/
    }
}

#Preview {
    CoreImageAndSwiftUI()
}
