//
//  StringExtensions.swift
//  Weight
//
//  Created by Alex Littlejohn on 2016/02/24.
//  Copyright © 2016 Alex Littlejohn. All rights reserved.
//

import UIKit

extension String {
    func subString(_ start: Int, length: Int) -> String {
        let _start = characters.index(startIndex, offsetBy: start)
        let _end = characters.index(startIndex, offsetBy: start + length)
        return substring(with: _start..<_end)
    }
}

extension String {
    func size(_ attributes: [String:AnyObject], constrainedSize: CGSize) -> CGSize {
        let storage = NSTextStorage(string: self)
        let container = NSTextContainer(size: CGSize(width: constrainedSize.width, height: constrainedSize.height))
        let layout = NSLayoutManager()
        layout.addTextContainer(container)
        storage.addLayoutManager(layout)
        storage.addAttributes(attributes, range: NSMakeRange(0, storage.length))
        container.lineFragmentPadding = 0.0
        let _ = layout.glyphRange(for: container)
        return layout.usedRect(for: container).size
    }
}

extension String {
    func trim() -> String {
        return trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
}

extension String {
    var length: Int {
        return lengthOfBytes(using: String.Encoding.utf8)
    }
}

func localizedString(_ key: String) -> String {
    return NSLocalizedString(key, tableName: "Localizable", bundle: Bundle.main, comment: key)
}
