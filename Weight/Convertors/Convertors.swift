//
//  Convertors.swift
//  Weight
//
//  Created by Alex Littlejohn on 2016/03/11.
//  Copyright © 2016 Alex Littlejohn. All rights reserved.
//

import UIKit

func kilogramsToStone(_ value: Double) -> Double {
    return value / 6.35029
}

func kilogramsToPounds(_ value: Double) -> Double {
    return value * 2.20462
}

func poundsToStone(_ value: Double) -> Double {
    return value / 14
}

func poundsToKilograms(_ value: Double) -> Double {
    return value / 2.20462
}

func stoneToPounds(_ value: Double) -> Double {
    return value * 14
}

func stoneToKilograms(_ value: Double) -> Double {
    return value * 6.35029
}

func convert(_ value: Double, unit: Unit, targetUnit: Unit) -> Double {
    switch unit {
    case .kilograms:
        switch targetUnit {
        case .pounds:
            return kilogramsToPounds(value)
        case .stone:
            return kilogramsToStone(value)
        case .kilograms:
            return value
        }
    case .pounds:
        switch targetUnit {
        case .pounds:
            return value
        case .stone:
            return poundsToStone(value)
        case .kilograms:
            return poundsToKilograms(value)
        }
    case .stone:
        switch targetUnit {
        case .pounds:
            return stoneToPounds(value)
        case .stone:
            return value
        case .kilograms:
            return stoneToKilograms(value)
        }
    }
}
