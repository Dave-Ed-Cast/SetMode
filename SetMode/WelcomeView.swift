//
//  ContentView.swift
//  Test
//
//  Created by Davide Castaldi on 04/04/25.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct WelcomeView: View {
    
    @Environment(\.setMode) private var setMode
    
    var body: some View {
        VStack(spacing: 18) {
            Text("Welcome!")
                .font(.extraLargeTitle)
            
            Text("This is a test video!")
                .font(.title)
            
            Button("Go to main screen") {
                Task{ await setMode(.mainScreen) }
            }
        }
    }
}
