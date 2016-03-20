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
        case Item, UnitItem
        
        var font: UIFont {
            
            switch self {
            case .Item:
                return UIFont(name: "HelveticaNeue-Light", size: 48)!
            case .UnitItem:
                return UIFont(name: "HelveticaNeue-Light", size: 28)!
            }
        }
    }
    
    enum NavigationBar {
        case Title
        
        var font: UIFont {
            switch self {
            case .Title:
                return UIFont(name: "HelveticaNeue-Light", size: 24)!
            }
        }
    }

    enum DateButton {
        case Title
        
        var font: UIFont {
            switch self {
            case .Title:
                return UIFont(name: "HelveticaNeue-Light", size: 16)!
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
    
    enum NavigationBar {
        case Title
        
        var color: UIColor {
            switch self {
            case .Title:
                return UIColor(hexString: "#34495E")
            }
        }
    }
    
    enum DateButton {
        case Title
        
        var color: UIColor {
            switch self {
            case .Title:
                return UIColor(hexString: "#34495E")
            }
        }
    }
}