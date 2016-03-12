//
//  Units.swift
//  Weight
//
//  Created by Alex Littlejohn on 2016/03/12.
//  Copyright © 2016 Alex Littlejohn. All rights reserved.
//

import UIKit

enum Unit: Int, CustomStringConvertible {
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
