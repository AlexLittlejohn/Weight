//
//  AppReducer.swift
//  Weight
//
//  Created by Alex Littlejohn on 2016/02/22.
//  Copyright © 2016 Alex Littlejohn. All rights reserved.
//

import ReSwift
import ReSwiftRouter

struct AppReducer: Reducer {
    func handleAction(action: Action, state: AppState?) -> AppState {
        return AppState(
            weights: weightReducer(action, weights: state?.weights),
            navigationState: NavigationReducer.handleAction(action, state: state?.navigationState),
            unit: state?.unit ?? .Kilograms,
            captureMode: captureModeReducer(action, mode: state?.captureMode),
            goal: goalReducer(action, goal: state?.goal)
        )
    }
}