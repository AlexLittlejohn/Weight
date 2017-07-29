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
        case item, unitItem
        
        var font: UIFont {
            
            switch self {
            case .item:
                return UIFont(name: "HelveticaNeue-Light", size: 48)!
            case .unitItem:
                return UIFont(name: "HelveticaNeue-Light", size: 28)!
            }
        }
    }
    
    enum NavigationBar {
        case title
        
        var font: UIFont {
            switch self {
            case .title:
                return UIFont(name: "HelveticaNeue-Light", size: 24)!
            }
        }
    }

    enum DateButton {
        case title
        
        var font: UIFont {
            switch self {
            case .title:
                return UIFont(name: "HelveticaNeue-Light", size: 16)!
            }
        }
    }
}

enum Colors {
    enum PickerView {
        case item, itemSelected, itemBackground, itemSelectedBackground
        
        var color: UIColor {
            switch self {
            case .item:
                return UIColor(hexString: "BDC3C7")
            case .itemSelected:
                return UIColor(hexString: "3498DB")
            case .itemBackground:
                return UIColor(hexString: "fff")
            case .itemSelectedBackground:
                return UIColor(hexString: "fff")
            }
        }
    }
    
    enum NavigationBar {
        case title
        
        var color: UIColor {
            switch self {
            case .title:
                return UIColor(hexString: "#34495E")
            }
        }
    }
    
    enum DateButton {
        case title
        
        var color: UIColor {
            switch self {
            case .title:
                return UIColor(hexString: "#34495E")
            }
        }
    }
    
    enum Chart {
        case background, label, line, circle, popup, popupBackground
        
        var color: UIColor {
            switch self {
            case .background:
                return UIColor(hexString: "fff")
            case .label:
                return UIColor(hexString: "34495E")
            case .line:
                return UIColor(hexString: "3498DB")
            case .circle:
                return UIColor(hexString: "3498DB")
            case .popup:
                return UIColor(hexString: "fff")
            case .popupBackground:
                return UIColor(hexString: "3498DB")
            }
        }
    }
}
