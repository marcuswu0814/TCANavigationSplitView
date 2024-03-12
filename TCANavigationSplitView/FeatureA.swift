//
//  FeatureA.swift
//  TCANavigationSplitView
//
//  Created by Marcus Wu on 2024/3/12.
//

import ComposableArchitecture
import SwiftUI

@Reducer
struct IntFeature {
    
    @ObservableState
    struct State: Equatable {
        
        let value: Int
        
    }
    
    enum Action {}
    
}

struct IntFeatureView: View {
    
    let store: StoreOf<IntFeature>
    
    var body: some View {
        Text("\(store.value)")
    }
    
}

@Reducer
struct TabAFeature {
    
    @Reducer(state: .equatable)
    enum Path {
        case detail(IntFeature)
    }
    
    @ObservableState
    struct State: Equatable {
        var path = StackState<Path.State>()
    }
    
    enum Action {
        case path(StackAction<Path.State, Path.Action>)
    }
    
    var body: some Reducer<State, Action> {
        Reduce(core)
            .forEach(\.path, action: \.path)
    }
    
    private func core(_ state: inout State, action: Action) -> Effect<Action> {
        switch action {
        default: break
        }
        
        return .none
    }
    
}

struct TabAView: View {
    
    @Bindable var store: StoreOf<TabAFeature>
    
    var body: some View {
        NavigationStack(path: $store.scope(state: \.path, action: \.path)) {
            Form {
                NavigationLink(
                    "1",
                    state: TabAFeature.Path.State.detail(
                        .init(
                            value: 1
                        )
                    )
                )
            }
        } destination: { store in
            switch store.case {
            case let .detail(store):
                IntFeatureView(store: store)
            }
        }
        .navigationTitle("Feature A")
    }
    
}
