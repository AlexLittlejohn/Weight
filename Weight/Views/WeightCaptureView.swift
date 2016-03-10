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
    
    func commonInit() {
        
        var sections = [PickerSection]()
        
        for i in 0..<3 {
            switch i {
            case 0:
                var items = [PickerItem]()
                for i in 0..<1000 {
                    let item = PickerItem(title: "\(i)")
                    items.append(item)
                }
                let section = PickerSection(items: items, width: 100)
                sections.append(section)
            case 1:
                var items = [PickerItem]()
                for i in 0.stride(to: 100, by: 5) {
                    let item = PickerItem(title: String(format: "%02d", i))
                    items.append(item)
                }
                let section = PickerSection(items: items, width: 100)
                sections.append(section)
            case 2:
                var items = [PickerItem]()
                for i in 0..<3 {
                    let item = PickerItem(title: "\(Units(rawValue: i)!)")
                    items.append(item)
                }
                let section = PickerSection(items: items, width: 100)
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
