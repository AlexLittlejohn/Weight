//
//  PickerItemView.swift
//  Weight
//
//  Created by Alex Littlejohn on 2016/03/02.
//  Copyright © 2016 Alex Littlejohn. All rights reserved.
//

import UIKit

class PickerItemView: UICollectionViewCell {
    
    let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        addSubview(label)
        label.textAlignment = .Center
        label.font = Typography.PickerView.Item.font
        label.textColor = Colors.PickerView.Item.color
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = bounds.insetBy(dx: 5, dy: 5)
    }
    
    override var selected: Bool {
        didSet {
            if selected {
                label.textColor = Colors.PickerView.ItemSelected.color
                backgroundColor = Colors.PickerView.ItemSelectedBackground.color
            } else {
                label.textColor = Colors.PickerView.Item.color
                backgroundColor = Colors.PickerView.ItemBackground.color
            }
        }
    }
}
