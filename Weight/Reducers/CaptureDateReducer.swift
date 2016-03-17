//
//  CaptureDateReducer.swift
//  Weight
//
//  Created by Alex Littlejohn on 2016/03/17.
//  Copyright © 2016 Alex Littlejohn. All rights reserved.
//

import ReSwift
import ReSwiftRouter

func captureDateReducer(action: Action, date: NSDate?) -> NSDate {
    
    var _date = date ?? NSDate()
    
    switch action {
    case let action as SetDateAction:
        _date = action.date
    default:
        break
    }
    
    return _date
}
