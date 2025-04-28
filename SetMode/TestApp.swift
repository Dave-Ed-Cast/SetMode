//
//  TestApp.swift
//  Test
//
//  Created by Davide Castaldi on 04/04/25.
//

import SwiftUI

@main
struct TestApp: App {
    
    @Environment(\.openWindow) private var openWindow
    @Environment(\.dismissWindow) private var dismissWindow
    @Environment(\.openImmersiveSpace) private var openImmersiveSpace
    @Environment(\.dismissImmersiveSpace) private var dismissImmersiveSpace
        
    @State private var mode: Mode = .welcome
    @State private var immersiveSpacePresented: Bool = false
    @State private var overlappingWindows: [String] = []
    
    enum Mode: Equatable {
        case welcome, mainScreen, window1, window2, window3, window31
        case immersive1, immersive2, immersive3
        
        /// Indicates if the mode requires an immersive space.
        fileprivate var needsImmersiveSpace: Bool {
            switch self {
            case .immersive1, .immersive2, .immersive3: return true
            default: return false
            }
        }
        
        /// Indicates if the window should be closed when switching to next mode
        fileprivate var mustBeClosed: Bool {
            switch self {
            case .immersive1, .immersive2, .immersive3: return false
            default: return true
            }
        }
        
        fileprivate var mustOverlap: Bool {
            return self == .window3
        }
        
        /// Other possible variables needed...
        
        /// Returns the associated window identifier for the mode.
        fileprivate var windowId: String {
            switch self {
            case .welcome: return WindowIDs.welcomeWindowID
            case .mainScreen: return WindowIDs.mainScreenWindowID
            case .window1: return WindowIDs.window1WindowID
            case .window2: return WindowIDs.window2WindowID
            case .window3: return WindowIDs.window3WindowID
            case .window31: return WindowIDs.window31WindowID
            case .immersive1: return WindowIDs.immersiveSpace1ID
            case .immersive2: return WindowIDs.immersiveSpace2ID
            case .immersive3: return WindowIDs.immersiveSpace3ID
            }
            
        }
    }
    
    let possibleWindowIDs: [String] = [
        WindowIDs.welcomeWindowID,
        WindowIDs.mainScreenWindowID,
        WindowIDs.window1WindowID,
        WindowIDs.window2WindowID,
        WindowIDs.window3WindowID,
        WindowIDs.window31WindowID,
        WindowIDs.immersiveSpace1ID,
        WindowIDs.immersiveSpace2ID,
        WindowIDs.immersiveSpace3ID
    ]
    
    var body: some Scene {
        
        Group {
            Group {
                WindowGroup(id: WindowIDs.welcomeWindowID) { WelcomeView() }
                WindowGroup(id: WindowIDs.mainScreenWindowID) { MainView() }
                    .defaultWindowPlacement { content, context in
                        let size = content.sizeThatFits(.unspecified)
                        if let window = context.windows.first(where: { $0.id == WindowIDs.welcomeWindowID }) {
                            return WindowPlacement(.trailing(window), size: size)
                        }
                        
                        return WindowPlacement(.none)
                    }
                    
                WindowGroup(id: WindowIDs.window1WindowID) { Window1View() }
                    .defaultWindowPlacement { content, context in
                        let size = content.sizeThatFits(.infinity)
                        if let window = context.windows.first(where: { $0.id == WindowIDs.mainScreenWindowID }) {
                            return WindowPlacement(.below(window), size: size)
                        } else if let window = context.windows.first(where: { $0.id == WindowIDs.overlappingWindowID }) {
                            let size = content.sizeThatFits(.infinity)
                            return WindowPlacement(.above(window), size: size)
                        }
                        return WindowPlacement(.none)
                    }
                WindowGroup(id: WindowIDs.window2WindowID) { Window2View() }
                WindowGroup(id: WindowIDs.window3WindowID) { Window3View() }
                WindowGroup(id: WindowIDs.window31WindowID) { Window31View() }
                    .defaultWindowPlacement { content, context in
                        let size = content.sizeThatFits(.infinity)
                        if let window = context.windows.first(where: { $0.id == WindowIDs.window3WindowID }) {
                            return WindowPlacement(.leading(window), size: size)
                        }
                        return WindowPlacement(.none)
                    }
                WindowGroup(id: WindowIDs.overlappingWindowID) { OverlapView() }
                    .defaultWindowPlacement { content, context in
                        let size = content.sizeThatFits(.infinity)
                        
                        for id in possibleWindowIDs {
                            if let window = context.windows.first(where: { $0.id == id }) {
                                switch id {
                                case WindowIDs.mainScreenWindowID:
                                    return WindowPlacement(.below(window), size: size)
                                default:
                                    return WindowPlacement(.replacing(window), size: size)
                                }
                            }
                        }
                        return WindowPlacement(.none)
                    }
                    .defaultSize(width: 0.2, height: 0.1, depth: 0, in: .meters)
            }
            .defaultSize(width: 0.4, height: 0.25, depth: 0, in: .meters)
            
            Group {
                ImmersiveSpace(id: WindowIDs.immersiveSpace1ID) { ImmersiveView1() }
                ImmersiveSpace(id: WindowIDs.immersiveSpace2ID) { ImmersiveView2() }
                ImmersiveSpace(id: WindowIDs.immersiveSpace3ID) { ImmersiveView3() }
            }
        }
        .environment(\.setMode, setMode)
    }
    
    @MainActor private func setMode(_ newMode: Mode) async {
        // This avoids any unexpected behaviour
        let oldMode = mode
        guard newMode != oldMode else { return }
        mode = newMode
        
        print("oldMode: \(oldMode), newMode: \(newMode)")
                    
        /// Some delay is introduced due to possible failures during opening and closing
        switch immersiveSpacePresented {
        case true:
            
            await dismissImmersiveSpace()
            immersiveSpacePresented = false
            
            openWindow(id: newMode.windowId)
            try? await Task.sleep(for: .seconds(0.1))
            dismissWindow(id: WindowIDs.overlappingWindowID)
            
        case false:
            
            if oldMode.mustOverlap {
                
                openWindow(id: newMode.windowId)
                overlappingWindows.append(newMode.windowId)
                
                //Then, overlap the root window on which everybody else must overlap
                overlappingWindows.append(WindowIDs.window3WindowID)
                
            } else if oldMode.mustBeClosed && !newMode.needsImmersiveSpace {
                
                openWindow(id: newMode.windowId)
                try? await Task.sleep(for: .seconds(0.1))
                dismissWindow(id: oldMode.windowId)
                
            }
            
            if newMode.needsImmersiveSpace {

                immersiveSpacePresented = true
                await openImmersiveSpace(id: newMode.windowId)
                openWindow(id: WindowIDs.overlappingWindowID)
                  
                // If nothing is in the "overlapping" state
                guard !overlappingWindows.isEmpty else {
                    dismissWindow(id: oldMode.windowId)
                    return
                }
                
                for window in overlappingWindows {
                    try? await Task.sleep(for: .seconds(0.1))
                    dismissWindow(id: window)
                }
                overlappingWindows.removeAll()
            }
        }
    }
}
