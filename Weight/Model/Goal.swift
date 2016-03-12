//
//  Goal.swift
//  Weight
//
//  Created by Alex Littlejohn on 2016/03/12.
//  Copyright © 2016 Alex Littlejohn. All rights reserved.
//

import UIKit

struct Goal {
    let weight: Double
    let unit: Unit
}

extension Goal {
    func convertTo(toUnit: Unit) -> Double {
        return convert(weight, unit: unit, targetUnit: toUnit)
    }
}