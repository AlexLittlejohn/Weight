//
//  WeightCaptureView.swift
//  Weight
//
//  Created by Alex Littlejohn on 2016/02/26.
//  Copyright © 2016 Alex Littlejohn. All rights reserved.
//

import UIKit

class WeightCaptureView: UIView {

    var pickerView: PickerView!
    let units = Units.Kilograms
    
    init() {
        super.init(frame: CGRect.zero)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func getWeightValue() -> Weight? {
        let selection = pickerView.selection
        let sorted = Array(selection.keys).sort(<)
        
        var weightString = ""
        for i in 0..<3 {
            guard let value = selection[sorted[i]]?.title else {
                continue
            }
            weightString += value.trim()
        }
        
        let formatter = NSNumberFormatter()
        formatter.numberStyle = .DecimalStyle
        guard let weightDouble = formatter.numberFromString(weightString)?.doubleValue else {
            return nil
        }
        
        guard let unitString = selection[sorted[3]]?.title else {
            return nil
        }
        
        let units: Units
        
        switch unitString {
        case "lbs":
            units = .Pounds
        case "stone":
            units = .Stone
        default:
            units = .Kilograms
        }
        
        let weight = Weight(weight: weightDouble, date: NSDate(), units: units)
        return weight
    }
    
    func commonInit() {
        
        var sections = [PickerSection]()
        
        for i in 0..<4 {
            switch i {
            case 0:
                var items = [PickerItem]()
                for i in 0..<1000 {
                    let item = PickerItem(title: "\(i)")
                    items.append(item)
                }
                let section = PickerSection(items: items, width: 100, font: Typography.PickerView.Item.font, alignment: .Right)
                sections.append(section)
            case 1:
                let item = PickerItem(title: NSNumberFormatter().decimalSeparator)
                let section = PickerSection(items: [item], width: 10, font: Typography.PickerView.Item.font, alignment: .Center)
                sections.append(section)
            case 2:
                var items = [PickerItem]()
                for i in 0.stride(to: 100, by: 5) {
                    let item = PickerItem(title: String(format: "%02d", i))
                    items.append(item)
                }
                let section = PickerSection(items: items, width: 60, font: Typography.PickerView.Item.font, alignment: .Left)
                sections.append(section)
            case 3:
                var items = [PickerItem]()
                for i in 0..<3 {
                    let item = PickerItem(title: "\(Units(rawValue: i)!)")
                    items.append(item)
                }
                let section = PickerSection(items: items, width: 70, font: Typography.PickerView.UnitItem.font, alignment: .Left)
                sections.append(section)
            default:
                break
            }
        }
        
        pickerView = PickerView(sections: sections)
        addSubview(pickerView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        pickerView.frame = bounds
    }
}
