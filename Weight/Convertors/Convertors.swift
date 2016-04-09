//
//  Convertors.swift
//  Weight
//
//  Created by Alex Littlejohn on 2016/03/11.
//  Copyright © 2016 Alex Littlejohn. All rights reserved.
//

import UIKit

func kilogramsToStone(value: Double) -> Double {
    return value / 6.35029
}

func kilogramsToPounds(value: Double) -> Double {
    return value * 2.20462
}

func poundsToStone(value: Double) -> Double {
    return value / 14
}

func poundsToKilograms(value: Double) -> Double {
    return value / 2.20462
}

func stoneToPounds(value: Double) -> Double {
    return value * 14
}

func stoneToKilograms(value: Double) -> Double {
    return value * 6.35029
}

func convert(value: Double, unit: Unit, targetUnit: Unit) -> Double {
    switch unit {
    case .Kilograms:
        switch targetUnit {
        case .Pounds:
            return kilogramsToPounds(value)
        case .Stone:
            return kilogramsToStone(value)
        case .Kilograms:
            return value
        }
    case .Pounds:
        switch targetUnit {
        case .Pounds:
            return value
        case .Stone:
            return poundsToStone(value)
        case .Kilograms:
            return poundsToKilograms(value)
        }
    case .Stone:
        switch targetUnit {
        case .Pounds:
            return stoneToPounds(value)
        case .Stone:
            return value
        case .Kilograms:
            return stoneToKilograms(value)
        }
    }
}