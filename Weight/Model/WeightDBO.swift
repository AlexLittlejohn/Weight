//
//  WeightDBO.swift
//  Weight
//
//  Created by Alex Littlejohn on 2016/03/12.
//  Copyright © 2016 Alex Littlejohn. All rights reserved.
//

import UIKit
import RealmSwift

class WeightDBO: Object {
    dynamic var weight: Double = 0
    dynamic var date = Date()
    dynamic var unit = 0
}

extension WeightDBO {
    func structValue() -> Weight {
        return Weight(weight: weight, date: date, unit: Unit(rawValue: unit) ?? .kilograms)
    }
}
