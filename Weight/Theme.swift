//
//  Typography.swift
//  Weight
//
//  Created by Alex Littlejohn on 2016/03/02.
//  Copyright © 2016 Alex Littlejohn. All rights reserved.
//

import UIKit


///TODO: Generate this

enum Typography {
    enum PickerView {
        case Item, BigItem, SmallItem, UnitItem
        
        var font: UIFont {
            
            switch self {
            case .Item:
                return UIFont(name: "HelveticaNeue-Light", size: 28)!
            case .BigItem:
                return UIFont(name: "HelveticaNeue-Light", size: 28)!
            case .SmallItem:
                return UIFont(name: "HelveticaNeue-Light", size: 28)!
            case .UnitItem:
                return UIFont(name: "HelveticaNeue-Light", size: 28)!
            }
        }
        
        
    }
}

enum Colors {
    enum PickerView {
        case Item, ItemSelected, ItemBackground, ItemSelectedBackground
        
        var color: UIColor {
            switch self {
            case .Item:
                return UIColor(hexString: "BDC3C7")
            case .ItemSelected:
                return UIColor(hexString: "3498DB")
            case .ItemBackground:
                return UIColor(hexString: "fff")
            case .ItemSelectedBackground:
                return UIColor(hexString: "fff")
            }
        }
    }
}