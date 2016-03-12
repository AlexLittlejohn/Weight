//
//  CaptureModeReducer.swift
//  Weight
//
//  Created by Alex Littlejohn on 2016/03/12.
//  Copyright © 2016 Alex Littlejohn. All rights reserved.
//

import ReSwift
import ReSwiftRouter

func captureModeReducer(action: Action, mode: CaptureMode?) -> CaptureMode {
    
    var _mode = mode ?? .Weight
    
    switch action {
    case let action as SetCaptureModeAction:
        _mode = action.mode
    default:
        break
    }
    
    return _mode
}
