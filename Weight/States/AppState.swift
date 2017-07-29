//
//  AppState.swift
//  Weight
//
//  Created by Alex Littlejohn on 2016/02/21.
//  Copyright © 2016 Alex Littlejohn. All rights reserved.
//

import RealmSwift
import ReSwift

struct AppState: StateType {
    var weights: [Weight]
    var unit: Unit
    var captureMode: CaptureMode
    var captureDate: Date
    var goal: Goal?
}

func populatedAppState() -> AppState {
    let realm = try! Realm()
    let weights: [Weight] = realm.objects(WeightDBO.self).flatMap { $0.structValue() }
    let goal = realm.objects(GoalDBO.self).first?.structValue() ?? nil

    return AppState(
        weights: weights,
        unit: .kilograms,
        captureMode: .weight,
        captureDate: Date(),
        goal: goal
    )
}
