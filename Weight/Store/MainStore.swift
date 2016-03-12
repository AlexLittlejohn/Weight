//
//  MainStore.swift
//  Weight
//
//  Created by Alex Littlejohn on 2016/02/22.
//  Copyright © 2016 Alex Littlejohn. All rights reserved.
//

import UIKit
import ReSwift

let mainStore = Store<AppState>(reducer: AppReducer(), state: populatedAppState(), middleware: [SaveWeightMiddleware, SaveGoalMiddleware])