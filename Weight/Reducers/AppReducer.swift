//
//  AppReducer.swift
//  Weight
//
//  Created by Alex Littlejohn on 2016/02/22.
//  Copyright © 2016 Alex Littlejohn. All rights reserved.
//

import ReSwift

func AppReducer(action: Action, state: AppState?) -> AppState {
    return AppState(
        weights: weightReducer(action: action, state: state?.weights),
        unit: state?.unit ?? .kilograms,
        captureMode: captureModeReducer(action: action, state: state?.captureMode),
        captureDate: captureDateReducer(action: action, state: state?.captureDate),
        goal: goalReducer(action: action, state: state?.goal)
    )
}


func captureDateReducer(action: Action, state: Date?) -> Date {
    switch action {
    case Actions.setDate(let date):
        return date
    default:
        return state ?? Date()
    }
}

func captureModeReducer(action: Action, state: CaptureMode?) -> CaptureMode {
    switch action {
    case Actions.setCaptureMoDe(let mode):
        return mode
    default:
        return state ?? .weight
    }
}

func goalReducer(action: Action, state: Goal?) -> Goal? {
    switch action {
    case Actions.addGoal(let goal):
        return goal
    default:
        return state
    }
}

func weightReducer(action: Action, state: [Weight]?) -> [Weight] {
    switch action {
    case Actions.addWeight(let weight):

        guard var state = state else {
            return [weight]
        }

        state.append(weight)

        return state
    default:
        return state ?? []
    }
}
