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
    
    func getValue() -> (weight: Double, unit: Unit)? {
        let selection = pickerView.selection
        let sorted = Array(selection.keys).sorted(by: <)
        
        var weightString = ""
        for i in 0..<3 {
            guard let value = selection[sorted[i]]?.title else {
                continue
            }
            weightString += value.trim()
        }
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        guard let weightDouble = formatter.number(from: weightString)?.doubleValue else {
            return nil
        }
        
        guard let unitString = selection[sorted[3]]?.title else {
            return (weight: weightDouble, unit: .kilograms)
        }
        
        let unit: Unit
        
        switch unitString {
        case localizedString("units.pounds"):
            unit = .pounds
        case localizedString("units.stone"):
            unit = .stone
        default:
            unit = .kilograms
        }
        
        return (weight: weightDouble, unit: unit)
    }
    
    func setValue(_ weight: Double, unit: Unit) {
        
        let wholeWeight = Int(round(weight))
        let weightFraction = Int(floor((weight.truncatingRemainder(dividingBy: 1)) * 100 / 5))
        let unitIndex = unit.rawValue
        
        pickerView.select(wholeWeight, section: 0, animated: false)
        pickerView.select(weightFraction, section: 2, animated: false)
        pickerView.select(unitIndex, section: 3, animated: false)
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
                let section = PickerSection(items: items, width: 100, font: Typography.PickerView.item.font, alignment: .right)
                sections.append(section)
            case 1:
                let item = PickerItem(title: NumberFormatter().decimalSeparator)
                let section = PickerSection(items: [item], width: 10, font: Typography.PickerView.item.font, alignment: .center)
                sections.append(section)
            case 2:
                var items = [PickerItem]()
                for i in stride(from: 0, to: 100, by: 5) {
                    let item = PickerItem(title: String(format: "%02d", i))
                    items.append(item)
                }
                let section = PickerSection(items: items, width: 60, font: Typography.PickerView.item.font, alignment: .left)
                sections.append(section)
            case 3:
                var items = [PickerItem]()
                for i in 0..<3 {
                    let item = PickerItem(title: "\(Unit(rawValue: i)!)")
                    items.append(item)
                }
                let section = PickerSection(items: items, width: 70, font: Typography.PickerView.unitItem.font, alignment: .left)
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
        
        // not very clean, but it has the desired effect
        guard let element = mainStore.state.weights.max(by: { $0.date >= $1.date }) else {
            return
        }
        
        setValue(element.weight, unit: element.unit)
    }
}
