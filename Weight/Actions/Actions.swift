//
//  Actions.swift
//  Weight
//
//  Created by Alex Littlejohn on 29/07/2017.
//  Copyright © 2017 Alex Littlejohn. All rights reserved.
//

import ReSwift

enum Actions: Action {
    case setDate(Date)
    case setCaptureMoDe(CaptureMode)
    case addWeight(Weight)
    case addGoal(Goal)
}
