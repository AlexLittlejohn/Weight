//
//  AppState.swift
//  Weight
//
//  Created by Alex Littlejohn on 2016/02/21.
//  Copyright © 2016 Alex Littlejohn. All rights reserved.
//

import RealmSwift
import ReSwift
import ReSwiftRouter

struct AppState: StateType {
    var weights: [Weight]
    var navigationState: NavigationState
    var unit: Unit
    var captureMode: CaptureMode
    var captureDate: NSDate
    var goal: Goal?
}

func populatedAppState() -> AppState {
    let realm = try! Realm()
    let weights = realm.objects(WeightDBO).map { $0.structValue() }
    let goal = realm.objects(GoalDBO).first?.structValue() ?? nil
    let action = SetRouteAction([WeightViewController.identifier])

    return AppState(
        weights: weights,
        navigationState: NavigationReducer.handleAction(action, state: nil),
        unit: .Kilograms,
        captureMode: .Weight,
        captureDate: NSDate(),
        goal: goal
    )
}
