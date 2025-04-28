//
//  SetModeKey.swift
//  Test
//
//  Created by Davide Castaldi on 04/04/25.
//

import SwiftUI

/// The defualt value can be `nonisolated(unsafe)` because
/// it will be protected in the function through the `MainActor`
struct SetModeKey: EnvironmentKey {
    typealias Value = (TestApp.Mode) async -> Void
    nonisolated(unsafe) static let defaultValue: Value = { _ in }
}

extension EnvironmentValues {
    var setMode: SetModeKey.Value {
        get { self[SetModeKey.self] }
        set { self[SetModeKey.self] = newValue }
    }
}
