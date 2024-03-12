//
//  ContentView.swift
//  TCANavigationSplitView
//
//  Created by Marcus Wu on 2024/3/12.
//

import ComposableArchitecture
import SwiftUI

@Reducer
struct Feature {
    
    @ObservableState
    struct State: Equatable {
        enum Tab {
            case tabA, tabB, tabC
        }
        
        var activeTab: Tab? = .tabA
        var tabA: TabAFeature.State = .init()
        var tabB: TabBFeature.State = .init()
        var tabC: TabCFeature.State = .init()
    }
    
    enum Action: BindableAction {
        case binding(BindingAction<State>)
        case tabA(TabAFeature.Action)
        case tabB(TabBFeature.Action)
        case tabC(TabCFeature.Action)
    }
    
    var body: some Reducer<State, Action> {
        BindingReducer()
        Scope(state: \.tabA, action: \.tabA) {
            TabAFeature()
        }
        Scope(state: \.tabB, action: \.tabB) {
            TabBFeature()
        }
        Scope(state: \.tabC, action: \.tabC) {
            TabCFeature()
        }
        Reduce(core)
    }
    
    private func core(_ state: inout State, action: Action) -> Effect<Action> {
        switch action {
        default: break
        }
        
        return .none
    }
    
    
}

struct ContentView: View {
    
    @Bindable var store: StoreOf<Feature>
    
    var body: some View {
        NavigationSplitView {
            List(selection: $store.activeTab) {
                Section("A Section") {
                    NavigationLink("Tab A", value: Feature.State.Tab.tabA)
                }
                
                Section("B Section") {
                    NavigationLink("Tab B", value: Feature.State.Tab.tabB)
                }
                
                Section("C Section") {
                    NavigationLink("Tab C", value: Feature.State.Tab.tabC)
                }
            }
        } detail: {
            if let active = store.activeTab {
                switch active {
                case .tabA:
                    TabAView(store: store.scope(state: \.tabA, action: \.tabA))
                    
                case .tabB:
                    TabBView(store: store.scope(state: \.tabB, action: \.tabB))
                    
                case .tabC:
                    TabCView(store: store.scope(state: \.tabC, action: \.tabC))
                }
            }
        }
    }
    
}
