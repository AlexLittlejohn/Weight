//
//  UIColorExtensions.swift
//  Weight
//
//  Created by Alex Littlejohn on 2016/03/10.
//  Copyright © 2016 Alex Littlejohn. All rights reserved.
//

import UIKit

private func extractColorComponent(_ colorString: String, start: Int, length: Int) -> CGFloat {
    let substring = colorString.subString(start, length: length)
    let fullHex = length == 2 ? substring : substring + substring
    var hexComponent:CUnsignedInt = 0
    Scanner(string: fullHex).scanHexInt32(&hexComponent)
    return CGFloat(hexComponent) / CGFloat(255)
}

/// String init
extension UIColor {
    convenience init(hexString: String) {
        let colorString = hexString.replacingOccurrences(of: "#:", with: "").uppercased()
        
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        switch colorString.lengthOfBytes(using: String.Encoding.utf8) {
        case 3:
            red = extractColorComponent(colorString, start: 0, length: 1)
            green = extractColorComponent(colorString, start: 1, length: 1)
            blue = extractColorComponent(colorString, start: 2, length: 1)
            alpha = 1.0
        case 4:
            red = extractColorComponent(colorString, start: 0, length: 1)
            green = extractColorComponent(colorString, start: 1, length: 1)
            blue = extractColorComponent(colorString, start: 2, length: 1)
            alpha = extractColorComponent(colorString, start: 3, length: 1)
        case 6:
            red = extractColorComponent(colorString, start: 0, length: 2)
            green = extractColorComponent(colorString, start: 2, length: 2)
            blue = extractColorComponent(colorString, start: 4, length: 2)
            alpha = 1.0
        case 8:
            red = extractColorComponent(colorString, start: 0, length: 2)
            green = extractColorComponent(colorString, start: 2, length: 2)
            blue = extractColorComponent(colorString, start: 4, length: 2)
            alpha = extractColorComponent(colorString, start: 6, length: 2)
            
        default:
            print("Color value \(hexString) is invalid.  It should be a hex value of the form #RBG, #RGBA, #RRGGBB, or #RRGGBBAA")
            red = 0
            green = 0
            blue = 0
            alpha = 1
        }
        
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}

/// Brightness
extension UIColor {
    func darken20() -> UIColor? {
        return brightness(0.8)
    }
    
    func darken40() -> UIColor? {
        return brightness(0.6)
    }
    
    func lighten20() -> UIColor? {
        return brightness(1.2)
    }
    
    func lighten40() -> UIColor? {
        return brightness(1.4)
    }
    
    func brightness(_ brightness: CGFloat) -> UIColor? {
        var h: CGFloat = 0
        var s: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        
        if getHue(&h, saturation: &s, brightness: &b, alpha: &a) {
            return UIColor(hue: h, saturation: s, brightness: b * brightness, alpha: a)
        }
        
        return nil
    }
}

extension UIColor {
    func interpolate(_ end: UIColor, progress: CGFloat) -> UIColor {
        var f = max(0, progress)
        f = min(1, progress)
        
        let c1 = self.cgColor.components
        let c2 = end.cgColor.components
        
        let r: CGFloat = CGFloat(c1![0] + (c2![0] - c1![0]) * f)
        let g: CGFloat = CGFloat(c1![1] + (c2![1] - c1![1]) * f)
        let b: CGFloat = CGFloat(c1![2] + (c2![2] - c1![2]) * f)
        let a: CGFloat = CGFloat(c1![3] + (c2![3] - c1![3]) * f)
        
        return UIColor.init(red:r, green:g, blue:b, alpha:a)
    }
}
