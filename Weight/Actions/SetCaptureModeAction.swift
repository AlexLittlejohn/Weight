//
//  SetCaptureModeAction.swift
//  Weight
//
//  Created by Alex Littlejohn on 2016/03/12.
//  Copyright © 2016 Alex Littlejohn. All rights reserved.
//

import UIKit
import ReSwift

struct SetCaptureModeAction: StandardActionConvertible {
    static let type = "\(SetCaptureModeAction.self)"
    
    let mode: CaptureMode
    
    init(mode: CaptureMode) {
        self.mode = mode
    }
    
    init(_ standardAction: StandardAction) {
        guard let m = standardAction.payload?["mode"] as? Int, captureMode = CaptureMode(rawValue: m) else {
            fatalError("cannot init action because reasons")
        }
        
        mode = captureMode
    }
    
    func toStandardAction() -> StandardAction {
        
        let payload: [String: AnyObject] = [
            "mode": mode.rawValue
        ]
        
        return StandardAction(type: AddGoalAction.type, payload: payload, isTypedAction: true)
    }
}
