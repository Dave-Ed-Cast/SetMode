//
//  ContentView.swift
//  Test
//
//  Created by Davide Castaldi on 04/04/25.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct Window3View: View {
    
    @Environment(\.setMode) private var setMode
    
    var body: some View {
        VStack(spacing: 8) {
            VStack {
                Text("This is window 3")
                Group {
                    Text("The next button will open another window")
                    Text("without closing the old one")
                }
                .font(.body)
            }
            .font(.headline)
            .multilineTextAlignment(.center)
            
            Button("Window 3.1") {
                Task { await setMode(.window31) }
            }
        }
        
    }
}
