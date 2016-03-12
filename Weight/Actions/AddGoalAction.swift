//
//  AddGoalAction.swift
//  Weight
//
//  Created by Alex Littlejohn on 2016/03/12.
//  Copyright © 2016 Alex Littlejohn. All rights reserved.
//

import UIKit
import ReSwift

struct AddGoalAction: StandardActionConvertible {
    static let type = "\(AddGoalAction.self)"
    
    let goal: Goal
    
    init(goal: Goal) {
        self.goal = goal
    }
    
    init(_ standardAction: StandardAction) {
        guard let w = standardAction.payload?["weight"] as? Double, u = standardAction.payload?["unit"] as? Int, unit = Unit(rawValue: u) else {
            fatalError("cannot init action because reasons")
        }
        
        goal = Goal(weight: w, unit: unit)
    }
    
    func toStandardAction() -> StandardAction {
        
        let payload: [String: AnyObject] = [
            "weight": goal.weight,
            "unit": goal.unit.rawValue
        ]
        
        return StandardAction(type: AddGoalAction.type, payload: payload, isTypedAction: true)
    }
}
