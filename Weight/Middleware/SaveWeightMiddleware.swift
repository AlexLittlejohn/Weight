//
//  SaveWeightMiddleware.swift
//  Weight
//
//  Created by Alex Littlejohn on 2016/02/21.
//  Copyright © 2016 Alex Littlejohn. All rights reserved.
//

import UIKit
import ReSwift
import RealmSwift

let SaveWeightMiddleware: Middleware = { dispatch, getState in
    return { next in
        return { action in
            
            if let addWeightAction = action as? AddWeightAction {
                
                let weightDBO = WeightDBO()
                let weight = addWeightAction.weight
                weightDBO.weight = weight.weight
                weightDBO.date = weight.date
                weightDBO.units = weight.units.rawValue
                
                guard let realm = try? Realm() else {
                    return next(action)
                }
                
                try! realm.write {
                    realm.add(weightDBO)
                }
            }
            
            return next(action)
        }
    }
}