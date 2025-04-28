//
//  ContentView.swift
//  Test
//
//  Created by Davide Castaldi on 04/04/25.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct MainView: View {
    
    @Environment(\.setMode) private var setMode
    
    var body: some View {
        VStack(spacing: 10) {
            Text("Nice! We are in the main screen")
                .font(.title)
            
            HStack(spacing: 15) {
                Button("Window 1") {
                    Task{ await setMode(.window1) }
                }
                
                Button("Immersive 2") {
                    Task{ await setMode(.immersive2) }
                }
                
                Button("Window 3") {
                    Task{ await setMode(.window3) }
                }
            }
            .padding()
        }
    }
}
