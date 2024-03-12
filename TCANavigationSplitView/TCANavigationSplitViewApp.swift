//
//  TCANavigationSplitViewApp.swift
//  TCANavigationSplitView
//
//  Created by Marcus Wu on 2024/3/12.
//

import SwiftUI

@main
struct TCANavigationSplitViewApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(
                store: .init(initialState: .init()) {
                    Feature()
                }
            )
        }
    }
}
