//
//  GoalDBO.swift
//  Weight
//
//  Created by Alex Littlejohn on 2016/03/12.
//  Copyright © 2016 Alex Littlejohn. All rights reserved.
//

import UIKit
import RealmSwift

class GoalDBO: Object {
    dynamic var weight: Double = 0
    dynamic var unit = 0
}

extension GoalDBO {
    func structValue() -> Goal {
        return Goal(weight: weight, unit: Unit(rawValue: unit) ?? .kilograms)
    }
}
