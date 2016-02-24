//
//  Weight.swift
//  Weight
//
//  Created by Alex Littlejohn on 2016/02/21.
//  Copyright © 2016 Alex Littlejohn. All rights reserved.
//

import UIKit
import RealmSwift

class WeightDBO: Object {
    dynamic var weight: Double = 0
    dynamic var date = NSDate()
}

struct Weight {
    let weight: Double
    let date: NSDate
}

extension WeightDBO {
    func structValue() -> Weight {
        return Weight(weight: weight, date: date)
    }
}