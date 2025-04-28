//
//  ContentView.swift
//  Test
//
//  Created by Davide Castaldi on 04/04/25.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct OverlapView: View {
    
    @Environment(\.setMode) private var setMode
    
    var body: some View {
        VStack(spacing: 18) {
            Text("Hey I am overlapping!")
                .font(.title)
            
            Button("Back to main") {
                Task { await setMode(.mainScreen) }
            }
        }
    }
}
