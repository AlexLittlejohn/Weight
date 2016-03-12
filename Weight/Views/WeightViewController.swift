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
    
    let units = Units.Kilograms
    
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
        
        let units = localizedString("units.kilograms")
        
        currentUnitsLabel.text = units
        goalUnitsLabel.text = units
        maxUnitsLabel.text = units
        minUnitsLabel.text = units
        
        let button = UIBarButtonItem(image: UIImage(named: "AddWeightIcon")!.imageWithRenderingMode(.AlwaysOriginal), style: .Plain, target: self, action: "addWeight")
        
        navigationItem.rightBarButtonItem = button
    }
    
    @IBAction func addWeight(sender: AnyObject) {
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
        
        updateCurrent(state.weights)
        updateMaximums(state.weights)
        updateMinimums(state.weights)
    }
    
    func updateMinimums(weights: [Weight]) {
        guard let element = weights.minElement({ $0.convertTo(self.units) < $1.convertTo(self.units) }) else {
            return
        }
        
        let weight = convert(element.weight, units: element.units, targetUnits: units)
        minLabel.text = String(format: "%.2f", weight)
    }
    
    func updateMaximums(weights: [Weight]) {
        guard let element = weights.maxElement({ $0.convertTo(self.units) < $1.convertTo(self.units) }) else {
            return
        }
        
        let weight = convert(element.weight, units: element.units, targetUnits: units)
        maxLabel.text = String(format: "%.2f", weight)
    }
    
    func updateGoal() {
        
    }
    
    func updateCurrent(weights: [Weight]) {
        guard let element = weights.maxElement({ $0.date > $1.date }) else {
            return
        }
        
        let formatter = NSDateFormatter()
        formatter.dateStyle = .LongStyle
        formatter.timeStyle = .NoStyle
        dateLabel.text = formatter.stringFromDate(element.date)
        
        let weight = convert(element.weight, units: element.units, targetUnits: units)
        currentWeightLabel.text = String(format: "%.2f", weight)

    }
}
