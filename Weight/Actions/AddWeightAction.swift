//
//  AddWeightAction.swift
//  Weight
//
//  Created by Alex Littlejohn on 2016/02/21.
//  Copyright © 2016 Alex Littlejohn. All rights reserved.
//

import UIKit
import ReSwift

struct AddWeightAction: StandardActionConvertible {
    
    static let type = "\(AddWeightAction.self)"
    
    let weight: Weight
    
    init(weight: Weight) {
        self.weight = weight
    }
    
    init(_ standardAction: StandardAction) {
        guard let w = standardAction.payload?["weight"] as? Double, d = standardAction.payload?["date"] as? NSDate else {
            fatalError("cannot init action because reasons")
        }
    
        weight = Weight(weight: w, date: d)
    }
    
    func toStandardAction() -> StandardAction {
        
        let payload: [String: AnyObject] = [
            "weight": weight.weight,
            "date": weight.date
        ]
        
        return StandardAction(type: AddWeightAction.type, payload: payload, isTypedAction: true)
    }
}