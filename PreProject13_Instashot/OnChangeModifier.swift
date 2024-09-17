//
//  ContentView.swift
//  PreProject13_Instashot
//
//  Created by Bruno Oliveira on 11/07/24.
//

import SwiftUI

struct OnChangeModifier: View {
    @State private var blurAmount = 0.0 /*{
        didSet {
            //this will be triggered only if I touch the button, don't the slider
            /*To understand what’s happening here, I want you to explore a little of how @State functions, and what property wrappers are actually doing for us.
            
            Property wrappers have that name because they wrap our property inside another struct. What this means is that when we use @State to wrap a string, the actual type of property we end up with is a State<String>. Similarly, when we use @Environment and others we end up with a struct of type Environment that contains some other value inside it.
             
             On the surface, that states “when blurAmount changes, print out its new value.” However, because @State actually wraps its contents, what it’s actually saying is that when the State struct that wraps blurAmount changes, print out the new blur amount.

             Still with me? Now let’s go a stage further: you’ve just seen how State wraps its value using a non-mutating setter, which means neither blurAmount or the State struct wrapping it are changing – our binding is directly changing the internally stored value, which means the property observer is never being triggered.

             So, changing the property directly using a button works fine, because it goes through the nonmutating setter and triggers the didSet observer, but using a binding doesn’t because it bypasses the setter and adjusts the value directly
             
             See on XCode Quick Open (Shift+comand+o and type state to open the swiftUI generaed interface) thease lines o code:
             
             @propertyWrapper public struct State<Value> : DynamicProperty {
             public var wrappedValue: Value { get nonmutating set }
             
             Because of the way SwiftUI sends binding updates to property wrappers, property observers used with property wrappers often won’t work the way you expect, which means this kind of code like the slider below won’t print anything even as the blur radius changes, just the Button code, because it don't use bidings:
             
             To fix this we need to use the onChange() modifier, which tells SwiftUI to run a function of our choosing when a particular value changes. SwiftUI will automatically pass in both the old and new value to whatever function you attach
             
             */
            
            print("The new blur amount is \(blurAmount)")
        }
    }*/
    
    var body: some View {
        VStack {
            Text("Hello, world!")
                .blur(radius: blurAmount)
            
            Slider(value: $blurAmount, in: 0...20)
                .onChange(of: blurAmount) { oldValue, newValue in
                    print("New Value is \(newValue)")
                }
            
            Button("Random Blur") {
                blurAmount = Double.random(in: 0...20)
            }
            .padding()
            
            Text("The blur amount is \(blurAmount)")
        }
        //You can attach onChange() wherever you want in your view hierarchy, but I prefer to put it near the thing that's actually changing.
        /*.onChange(of: blurAmount) { oldValue, newValue in
         print("New Value is \(newValue)")
     }*/
        .padding()
    }
}

#Preview {
    OnChangeModifier()
}
