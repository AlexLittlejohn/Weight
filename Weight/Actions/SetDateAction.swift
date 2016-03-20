//
//  SetDateAction.swift
//  Weight
//
//  Created by Alex Littlejohn on 2016/03/17.
//  Copyright © 2016 Alex Littlejohn. All rights reserved.
//

import ReSwift

class SetDateAction: Action {

    let date: NSDate
    
    init(date: NSDate) {
        self.date = date
    }
}
