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
        let action = SetRouteAction([WeightCaptureViewController.identifier])
        mainStore.dispatch(action)
    }
    
    @IBAction func addGoal(sender: AnyObject) {
        let action = SetRouteAction([WeightCaptureViewController.identifier])
        mainStore.dispatch(action)
    }
    
    override func viewWillAppear(animated: Bool) {
        mainStore.subscribe(self)
    }
    
    override func viewWillDisappear(animated: Bool) {
        mainStore.unsubscribe(self)
    }
    
    func newState(state: AppState) {
        updateCurrent(state.weights, units: state.units)
        updateMaximums(state.weights, units: state.units)
        updateMinimums(state.weights, units: state.units)
        updateUnits(state.units)
    }
    
    func updateUnits(units: Units) {
        currentUnitsLabel.text = units.description
        goalUnitsLabel.text = units.description
        maxUnitsLabel.text = units.description
        minUnitsLabel.text = units.description
    }
    
    func updateMinimums(weights: [Weight], units: Units) {
        guard let element = weights.minElement({ $0.convertTo(units) < $1.convertTo(units) }) else {
            return
        }
        
        minLabel.text = String(format: "%.2f", element.convertTo(units))
    }
    
    func updateMaximums(weights: [Weight], units: Units) {
        guard let element = weights.maxElement({ $0.convertTo(units) < $1.convertTo(units) }) else {
            return
        }
        
        maxLabel.text = String(format: "%.2f", element.convertTo(units))
    }
    
    func updateGoal() {
        
    }
    
    func updateCurrent(weights: [Weight], units: Units) {
        guard let element = weights.maxElement({ $0.date > $1.date }) else {
            return
        }
        
        let formatter = NSDateFormatter()
        formatter.dateStyle = .LongStyle
        formatter.timeStyle = .NoStyle
        dateLabel.text = formatter.stringFromDate(element.date)
        
        currentWeightLabel.text = String(format: "%.2f", element.convertTo(units))

    }
}
