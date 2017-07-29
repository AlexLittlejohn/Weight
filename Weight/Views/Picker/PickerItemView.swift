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
        label.textAlignment = .center
        label.font = Typography.PickerView.item.font
        label.textColor = Colors.PickerView.item.color
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = bounds.insetBy(dx: 0, dy: 5)
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                label.textColor = Colors.PickerView.itemSelected.color
                backgroundColor = Colors.PickerView.itemSelectedBackground.color
            } else {
                label.textColor = Colors.PickerView.item.color
                backgroundColor = Colors.PickerView.itemBackground.color
            }
        }
    }
}
