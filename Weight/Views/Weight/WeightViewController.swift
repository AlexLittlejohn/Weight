//
//  WeightViewController.swift
//  Weight
//
//  Created by Alex Littlejohn on 2016/02/20.
//  Copyright © 2016 Alex Littlejohn. All rights reserved.
//

import UIKit
import ReSwift
import ReSwiftRouter

class WeightViewController: UIViewController, StoreSubscriber, Routable {

    static let identifier = "WeightViewController"
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var currentWeightLabel: UILabel!
    @IBOutlet weak var currentUnitsLabel: UILabel!
    
    @IBOutlet weak var goalTitleLabel: UILabel!
    @IBOutlet weak var goalLabel: UILabel!
    @IBOutlet weak var goalUnitsLabel: UILabel!
    @IBOutlet weak var addGoalButton: UIButton!
    
    @IBOutlet weak var maxTitleLabel: UILabel!
    @IBOutlet weak var maxLabel: UILabel!
    @IBOutlet weak var maxUnitsLabel: UILabel!
    
    @IBOutlet weak var minTitleLabel: UILabel!
    @IBOutlet weak var minLabel: UILabel!
    @IBOutlet weak var minUnitsLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        goalTitleLabel.text = localizedString("goalTitleLabel")
        maxTitleLabel.text = localizedString("maxTitleLabel")
        minTitleLabel.text = localizedString("minTitleLabel")
    }
    
    @IBAction func addWeight(sender: AnyObject) {
        let modeAction = SetCaptureModeAction(mode: .Weight)
        let dateAction = SetDateAction(date: NSDate())
        let navigateAction = SetRouteAction([WeightCaptureViewController.identifier])
        mainStore.dispatch(modeAction)
        mainStore.dispatch(dateAction)
        mainStore.dispatch(navigateAction)
    }
    
    @IBAction func addGoal(sender: AnyObject) {
        let modeAction = SetCaptureModeAction(mode: .Goal)
        let navigateAction = SetRouteAction([WeightCaptureViewController.identifier])
        mainStore.dispatch(modeAction)
        mainStore.dispatch(navigateAction)
    }
    
    override func viewWillAppear(animated: Bool) {
        mainStore.subscribe(self)
    }
    
    override func viewWillDisappear(animated: Bool) {
        mainStore.unsubscribe(self)
    }
    
    func newState(state: AppState) {
        updateCurrent(state.weights, unit: state.unit)
        updateMaximums(state.weights, unit: state.unit)
        updateMinimums(state.weights, unit: state.unit)
        updateUnits(state.unit)
        updateGoal(state.goal, unit: state.unit)
    }
    
    func updateUnits(unit: Unit) {
        currentUnitsLabel.text = unit.description
        goalUnitsLabel.text = unit.description
        maxUnitsLabel.text = unit.description
        minUnitsLabel.text = unit.description
    }
    
    func updateMinimums(weights: [Weight], unit: Unit) {
        guard let element = weights.minElement({ $0.convertTo(unit) < $1.convertTo(unit) }) else {
            return
        }
        
        minLabel.text = String(format: "%.2f", element.convertTo(unit))
    }
    
    func updateMaximums(weights: [Weight], unit: Unit) {
        guard let element = weights.maxElement({ $0.convertTo(unit) < $1.convertTo(unit) }) else {
            return
        }
        
        maxLabel.text = String(format: "%.2f", element.convertTo(unit))
    }
    
    func updateGoal(goal: Goal?, unit: Unit) {
        if let goal = goal {
            goalUnitsLabel.hidden = false
            goalLabel.hidden = false
            goalLabel.text = String(format: "%.2f", goal.convertTo(unit))
            addGoalButton.setTitle(localizedString("changeGoalButtonTitle"), forState: .Normal)
        } else {
            goalUnitsLabel.hidden = true
            goalLabel.hidden = true
            addGoalButton.setTitle(localizedString("addGoalButtonTitle"), forState: .Normal)
        }
    }
    
    func updateCurrent(weights: [Weight], unit: Unit) {
        guard let element = weights.maxElement({ $0.date > $1.date }) else {
            return
        }
        
        let formatter = NSDateFormatter()
        formatter.dateStyle = .LongStyle
        formatter.timeStyle = .NoStyle
        dateLabel.text = formatter.stringFromDate(element.date)
        
        currentWeightLabel.text = String(format: "%.2f", element.convertTo(unit))

    }
}
