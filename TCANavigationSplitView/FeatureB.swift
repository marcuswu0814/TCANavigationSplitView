//
//  FeatureB.swift
//  TCANavigationSplitView
//
//  Created by Marcus Wu on 2024/3/12.
//

import ComposableArchitecture
import SwiftUI

@Reducer
struct StringFeature {
    
    @ObservableState
    struct State: Equatable {
        
        let value: String
        
    }
    
    enum Action {}
    
}

struct StringFeatureView: View {
    
    let store: StoreOf<StringFeature>
    
    var body: some View {
        Text(store.value)
    }
    
}

@Reducer
struct TabBFeature {
    
    @Reducer(state: .equatable)
    enum Path {
        case detail(StringFeature)
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

struct TabBView: View {
    
    @Bindable var store: StoreOf<TabBFeature>
    
    var body: some View {
        NavigationStack(path: $store.scope(state: \.path, action: \.path)) {
            Form {
                NavigationLink(
                    "a",
                    state: TabBFeature.Path.State.detail(
                        .init(
                            value: "a"
                        )
                    )
                )
            }
        } destination: { store in
            switch store.case {
            case let .detail(store):
                StringFeatureView(store: store)
            }
        }
        .navigationTitle("Feature B")
    }
    
}
