//
//  WeightCaptureViewController.swift
//  Weight
//
//  Created by Alex Littlejohn on 2016/02/20.
//  Copyright © 2016 Alex Littlejohn. All rights reserved.
//

import UIKit
import ReSwift
import ReSwiftRouter

class WeightCaptureViewController: UIViewController, StoreSubscriber, Routable {
    
    static let identifier = "WeightCaptureViewController"
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var weightPicker: WeightCaptureView!
    @IBOutlet weak var gradientView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    
    var captureMode: CaptureMode = .Weight
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gradient = CAGradientLayer()
        
        gradient.frame = gradientView.bounds
        gradient.colors = [UIColor.blackColor().CGColor, UIColor.blackColor().CGColor, UIColor.clearColor().CGColor]
        gradient.locations = [0.0, 0.65, 1.0]
        gradientView.layer.mask = gradient
        
        titleLabel.font = Typography.NavigationBar.Title.font
        titleLabel.textColor = Colors.NavigationBar.Title.color
        
        view.sendSubviewToBack(weightPicker)
    }
        
    @IBAction func confirm(sender: AnyObject) {
        guard let weight = weightPicker.getWeightValue() else {
            return
        }
        
        let addAction = action(captureMode, weight: weight)
        let navigateAction = SetRouteAction([WeightViewController.identifier])
        
        mainStore.dispatch(addAction)
        mainStore.dispatch(navigateAction)
    }
    
    @IBAction func cancel(sender: AnyObject) {
        let action = SetRouteAction([WeightViewController.identifier])
        mainStore.dispatch(action)
    }

    override func viewWillAppear(animated: Bool) {
        mainStore.subscribe(self)
    }
    
    override func viewWillDisappear(animated: Bool) {
        mainStore.unsubscribe(self)
    }
    
    func newState(state: AppState) {
        captureMode = state.captureMode
        configureTitle(state.captureMode)
    }
    
    func configureTitle(mode: CaptureMode) {
        titleLabel.text = title(mode)
    }
    
    func title(mode: CaptureMode) -> String {
        switch mode {
        case .Weight:
            return localizedString("addWeightTitle")
        case .Goal:
            return localizedString("addGoalTitle")
        }
    }
    
    func action(mode: CaptureMode, weight: Weight) -> StandardActionConvertible {
        if mode == .Goal {
            let goal = Goal(weight: weight.weight, unit:  weight.unit)
            return AddGoalAction(goal: goal)
        } else {
            return AddWeightAction(weight: weight)
        }
    }
}
