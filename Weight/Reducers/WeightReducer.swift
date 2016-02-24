//
//  WeightReduce.swift
//  Weight
//
//  Created by Alex Littlejohn on 2016/02/22.
//  Copyright © 2016 Alex Littlejohn. All rights reserved.
//

import ReSwift
import ReSwiftRouter

func weightReducer(action: Action, weights: [Weight]?) -> [Weight] {
    
    var _weights = weights ?? [Weight]()

    switch action {
    case let action as AddWeightAction:
        _weights.append(action.weight)
    default:
        break
    }
    
    return _weights
}
