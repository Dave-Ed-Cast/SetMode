//
//  ContentView.swift
//  Test
//
//  Created by Davide Castaldi on 04/04/25.
//

import SwiftUI
import RealityKit
import RealityKitContent
import VisionTextArc

struct ImmersiveView1: View {
    
    @Environment(\.setMode) private var setMode
    
    let vta = TextCurver.self
    
    var body: some View {
        RealityView { content in
            let configuration = vta.Configuration(
                color: .cyan,
                radius: 2,
                yPosition: 1.75
            )
            content.add(vta.curveText("This is immersive space number 1", configuration: configuration))
        }
    }
}
