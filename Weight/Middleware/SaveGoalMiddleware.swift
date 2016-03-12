//
//  SaveGoalMiddleware.swift
//  Weight
//
//  Created by Alex Littlejohn on 2016/03/12.
//  Copyright © 2016 Alex Littlejohn. All rights reserved.
//

import UIKit
import ReSwift
import RealmSwift

let SaveGoalMiddleware: Middleware = { dispatch, getState in
    return { next in
        return { action in
            
            if let addGoalAction = action as? AddGoalAction {
                
                let goalDBO = GoalDBO()
                let goal = addGoalAction.goal
                goalDBO.weight = goal.weight
                goalDBO.unit = goal.unit.rawValue
                
                guard let realm = try? Realm() else {
                    return next(action)
                }
                
                let goals = realm.objects(GoalDBO)
                
                try! realm.write {
                    realm.delete(goals)
                    realm.add(goalDBO)
                }
            }
            
            return next(action)
        }
    }
}