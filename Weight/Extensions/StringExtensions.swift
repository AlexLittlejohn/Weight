//
//  StringExtensions.swift
//  Weight
//
//  Created by Alex Littlejohn on 2016/02/24.
//  Copyright © 2016 Alex Littlejohn. All rights reserved.
//

import UIKit

extension String {
    var length: Int {
        return lengthOfBytesUsingEncoding(NSUTF8StringEncoding)
    }
}

func localizableString(key: String) -> String {
    return NSLocalizedString(key, tableName: "Localizable", bundle: NSBundle.mainBundle(), comment: key)
}