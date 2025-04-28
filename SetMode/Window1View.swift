//
//  ContentView.swift
//  Test
//
//  Created by Davide Castaldi on 04/04/25.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct Window1View: View {
    
    @Environment(\.setMode) private var setMode
    
    var body: some View {
        VStack {
            Text("This is window 1.")
                .font(.title)
            
            Text("Enter immersive space?")
                .font(.headline)
            
            Button("Yes") {
                Task { await setMode(.immersive1) }
            }
        }
    }
}
