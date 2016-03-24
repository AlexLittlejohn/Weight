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

extension Weight: Equatable { }

func ==(lhs: Weight, rhs: Weight) -> Bool {
    
    let w1 = lhs.convertTo(.Kilograms)
    let w2 = rhs.convertTo(.Kilograms)
    
    return w1 == w2 && lhs.date == rhs.date
}