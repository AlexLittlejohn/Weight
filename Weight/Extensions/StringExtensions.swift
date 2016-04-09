//
//  StringExtensions.swift
//  Weight
//
//  Created by Alex Littlejohn on 2016/02/24.
//  Copyright © 2016 Alex Littlejohn. All rights reserved.
//

import UIKit

extension String {
    func subString(start: Int, length: Int) -> String {
        let _start = startIndex.advancedBy(start)
        let _end = startIndex.advancedBy(start + length)
        return substringWithRange(_start..<_end)
    }
}

extension String {
    func size(attributes: [String:AnyObject], constrainedSize: CGSize) -> CGSize {
        let storage = NSTextStorage(string: self)
        let container = NSTextContainer(size: CGSize(width: constrainedSize.width, height: constrainedSize.height))
        let layout = NSLayoutManager()
        layout.addTextContainer(container)
        storage.addLayoutManager(layout)
        storage.addAttributes(attributes, range: NSMakeRange(0, storage.length))
        container.lineFragmentPadding = 0.0
        let _ = layout.glyphRangeForTextContainer(container)
        return layout.usedRectForTextContainer(container).size
    }
}

extension String {
    func trim() -> String {
        return stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
    }
}

extension String {
    var length: Int {
        return lengthOfBytesUsingEncoding(NSUTF8StringEncoding)
    }
}

func localizedString(key: String) -> String {
    return NSLocalizedString(key, tableName: "Localizable", bundle: NSBundle.mainBundle(), comment: key)
}