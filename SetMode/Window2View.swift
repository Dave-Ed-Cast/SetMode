//
//  ContentView.swift
//  Test
//
//  Created by Davide Castaldi on 04/04/25.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct Window2View: View {
    
    @Environment(\.setMode) private var setMode
    
    var body: some View {
        VStack {
            Text("Window2!")
                .font(.title)
            
            Button("Go to window 3") {
                Task { await setMode(.window3) }
            }
            
        }
    }
}
