//
//  GoalReducer.swift
//  Weight
//
//  Created by Alex Littlejohn on 2016/03/12.
//  Copyright © 2016 Alex Littlejohn. All rights reserved.
//

import ReSwift
import ReSwiftRouter

func goalReducer(action: Action, goal: Goal?) -> Goal? {
    
    var _goal = goal ?? nil
    
    switch action {
    case let action as AddGoalAction:
        _goal = action.goal
    default:
        break
    }
    
    return _goal
}

