//
//  Weight.swift
//  Weight
//
//  Created by Alex Littlejohn on 2016/02/21.
//  Copyright © 2016 Alex Littlejohn. All rights reserved.
//

import UIKit

struct Weight {
    let weight: Double
    let date: NSDate
    let unit: Unit
}

extension Weight {
    func convertTo(toUnit: Unit) -> Double {
        return convert(weight, unit: unit, targetUnit: toUnit)
    }
}