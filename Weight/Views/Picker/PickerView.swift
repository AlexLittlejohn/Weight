//
//  PickerView.swift
//  Weight
//
//  Created by Alex Littlejohn on 2016/02/26.
//  Copyright © 2016 Alex Littlejohn. All rights reserved.
//

import UIKit

struct PickerSection {
    let items: [PickerItem]
    var width: CGFloat = 0
    let height: CGFloat = 54
    let font: UIFont
    let alignment: NSTextAlignment
}

struct PickerItem {
    let title: String
}

class PickerView: UIView {

    let cellIdentifier = "PickerItemView"
    let sections: [PickerSection]

    var collectionViews = [UICollectionView]()
    
    var selection = [Int: PickerItem]()
    
    init(sections: [PickerSection]) {
        self.sections = sections
        super.init(frame: CGRect.zero)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func commonInit() {
        
        for section in sections {
            
            let layout = PickerLayout()
            layout.minimumInteritemSpacing = 0
            layout.minimumLineSpacing = 0
            layout.sectionInset = UIEdgeInsetsZero
            
            let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 1, height: 1), collectionViewLayout: layout)
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.registerClass(PickerItemView.self, forCellWithReuseIdentifier: cellIdentifier)
            collectionView.backgroundColor = .clearColor()
            collectionView.showsVerticalScrollIndicator = false
            
            let inset = (frame.height - section.height) / 2
            let insets = UIEdgeInsets(top: inset, left: 0, bottom: inset, right: 0)
            
            collectionView.contentInset = insets
            collectionView.addObserver(self, forKeyPath: "contentOffset", options: .New, context: nil)
            
            collectionViews.append(collectionView)
            
            addSubview(collectionView)
        }
    }
    
    deinit {
        for collectionView in collectionViews {
            collectionView.removeObserver(self, forKeyPath: "contentOffset")
        }
    }
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        
        if keyPath == "contentOffset" {
            guard let pointValue = change?[NSKeyValueChangeNewKey] as? NSValue, collectionView = object as? UICollectionView, sectionIndex = indexForView(collectionView) else {
                return
            }
            
            let section = sections[sectionIndex]
            let point = pointValue.CGPointValue()

            let itemOffset = point.y + collectionView.frame.height/2
            let itemIndex = Int(floor(itemOffset / section.height))
            
            let indexPath = NSIndexPath(forRow: itemIndex, inSection: 0)
            
            
            collectionView.selectItemAtIndexPath(indexPath, animated: true, scrollPosition: .None)
            
            select(itemIndex, sectionIndex: sectionIndex)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        var x: CGFloat = frame.width/2 - (sections.reduce(0) { (i, ii) -> CGFloat in
            return i + ii.width
        })/2
        
        let y: CGFloat = 0
        for (idx, section) in sections.enumerate() {
            let width = section.width > 0 ? section.width : frame.size.width / CGFloat(sections.count)
            let height = frame.height
            collectionViews[idx].frame = CGRect(x: x, y: y, width: width, height: height)
            x += width
            
            let inset = (frame.height - section.height) / 2
            let insets = UIEdgeInsets(top: inset, left: 0, bottom: inset, right: 0)
            
            collectionViews[idx].contentInset = insets
        }
    }
    
    func indexForView(collectionView: UICollectionView) -> Int? {
        return collectionViews.indexOf(collectionView)
    }
    
    func select(index: Int, section: Int, animated: Bool) {
        
        guard 0..<collectionViews.count ~= section else {
            return
        }
        
        let collectionView = collectionViews[section]
        let count = collectionView.numberOfItemsInSection(0)
        
        guard 0..<count ~= index else {
            return
        }
        
        let indexPath = NSIndexPath(forRow: index, inSection: 0)
        
        collectionView.delegate?.collectionView!(collectionView, didSelectItemAtIndexPath: indexPath)
    }
    
    func select(index: Int, sectionIndex: Int) {
        let section = sections[sectionIndex]
        let item: PickerItem
        if index >= section.items.count {
            item = section.items.last!
        } else if index < 0 {
            item = section.items[0]
        } else {
            item = section.items[index]
        }
        
        selection[sectionIndex] = item
    }
}

extension PickerView: UICollectionViewDelegateFlowLayout {
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let height = sections[indexForView(collectionView)!].height
        let width = collectionView.frame.width
        return CGSize(width: width, height: height)
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        guard let sectionIndex = indexForView(collectionView) else {
            return
        }
        
        let section = sections[sectionIndex]
        let offsetY = CGFloat(indexPath.row) * section.height - (collectionView.frame.height/2 - section.height/2)
        let offset = CGPoint(x: 0, y: offsetY)
        
        collectionView.setContentOffset(offset, animated: true)
    }
}

extension PickerView: UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let idx = indexForView(collectionView) else {
            return 0
        }
        
        return sections[idx].items.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellIdentifier, forIndexPath: indexPath) as! PickerItemView
        let section = sections[indexForView(collectionView)!]
        let item = section.items[indexPath.row]
        
        cell.label.font = section.font
        cell.label.textAlignment = section.alignment
        cell.label.text = item.title
        
        return cell
    }
}