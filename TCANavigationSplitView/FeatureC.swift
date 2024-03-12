//
//  FeatureC.swift
//  TCANavigationSplitView
//
//  Created by Marcus Wu on 2024/3/12.
//

import ComposableArchitecture
import SwiftUI

@Reducer
struct TabCFeature {}

struct TabCView: View {
    
    @Bindable var store: StoreOf<TabCFeature>
    
    var body: some View {
        Text("Tap me without crash")
    }
    
}
