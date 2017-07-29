//
//  Units.swift
//  Weight
//
//  Created by Alex Littlejohn on 2016/03/12.
//  Copyright © 2016 Alex Littlejohn. All rights reserved.
//

import UIKit

enum Unit: Int, CustomStringConvertible {
    case kilograms = 0, pounds = 1, stone = 2
    
    var description: String {
        switch self {
        case .kilograms:
            return localizedString("units.kilograms")
        case .pounds:
            return localizedString("units.pounds")
        case .stone:
            return localizedString("units.stone")
        }
    }
}
