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
    dynamic var units = 0
}

struct Weight {
    let weight: Double
    let date: NSDate
    let units: Units
}

extension WeightDBO {
    func structValue() -> Weight {
        return Weight(weight: weight, date: date, units: Units(rawValue: units)!)
    }
}

enum Units: Int, CustomStringConvertible {
    case Kilograms = 0, Pounds = 1, Stone = 2
    
    var description: String {
        switch self {
        case .Kilograms:
            return localizedString("units.kilograms")
        case .Pounds:
            return localizedString("units.pounds")
        case .Stone:
            return localizedString("units.stone")
        }
    }
}


extension Weight {
    func convertTo(toUnits: Units) -> Double {
        return convert(weight, units: units, targetUnits: toUnits)
    }
}