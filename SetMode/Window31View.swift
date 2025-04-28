//
//  ContentView.swift
//  Test
//
//  Created by Davide Castaldi on 04/04/25.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct Window31View: View {
    
    @Environment(\.setMode) private var setMode
    
    var body: some View {
        VStack(spacing: 8) {
            VStack {
                Text("This is window 3.1!")
                Text("The next button will bring you")
                Text("To the last immersive space")
            }
            .font(.headline)
            .multilineTextAlignment(.center)
            
            Button("Last immersive") {
                Task { await setMode(.immersive3) }
            }
        }
        
    }
}
