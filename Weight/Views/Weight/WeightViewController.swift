//
//  WeightViewController.swift
//  Weight
//
//  Created by Alex Littlejohn on 2016/02/20.
//  Copyright © 2016 Alex Littlejohn. All rights reserved.
//

import UIKit
import ReSwift

class WeightViewController: UIViewController, StoreSubscriber {
    
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

    @IBOutlet weak var chartView: ChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        goalTitleLabel.text = localizedString("goalTitleLabel")
        maxTitleLabel.text = localizedString("maxTitleLabel")
        minTitleLabel.text = localizedString("minTitleLabel")
    }
    
    @IBAction func addWeight(_ sender: AnyObject) {
        mainStore.dispatch(Actions.setCaptureMoDe(.weight))
        mainStore.dispatch(Actions.setDate(Date()))
    }
    
    @IBAction func addGoal(_ sender: AnyObject) {
        mainStore.dispatch(Actions.setCaptureMoDe(.goal))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        mainStore.subscribe(self)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        mainStore.unsubscribe(self)
    }
    
    func newState(state: AppState) {
        updateCurrent(state.weights, unit: state.unit)
        updateMaximums(state.weights, unit: state.unit)
        updateMinimums(state.weights, unit: state.unit)
        update(unit: state.unit)
        update(goal: state.goal, unit: state.unit)
    }
    
    func update(unit: Unit) {
        currentUnitsLabel.text = unit.description
        goalUnitsLabel.text = unit.description
        maxUnitsLabel.text = unit.description
        minUnitsLabel.text = unit.description
    }
    
    func updateMinimums(_ weights: [Weight], unit: Unit) {
        guard let element = weights.min(by: { $0.convertTo(unit) < $1.convertTo(unit) }) else {
            return
        }
        
        minLabel.text = String(format: "%.2f", element.convertTo(unit))
    }
    
    func updateMaximums(_ weights: [Weight], unit: Unit) {
        guard let element = weights.max(by: { $0.convertTo(unit) < $1.convertTo(unit) }) else {
            return
        }
        
        maxLabel.text = String(format: "%.2f", element.convertTo(unit))
    }
    
    func update(goal: Goal?, unit: Unit) {
        if let goal = goal {
            goalUnitsLabel.isHidden = false
            goalLabel.isHidden = false
            goalLabel.text = String(format: "%.2f", goal.convertTo(unit))
            addGoalButton.setTitle(localizedString("changeGoalButtonTitle"), for: UIControlState())
        } else {
            goalUnitsLabel.isHidden = true
            goalLabel.isHidden = true
            addGoalButton.setTitle(localizedString("addGoalButtonTitle"), for: UIControlState())
        }
    }
    
    func updateCurrent(_ weights: [Weight], unit: Unit) {
        guard let element = weights.max(by: { $0.date >= $1.date }) else {
            return
        }
        
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        dateLabel.text = formatter.string(from: element.date as Date)
        
        currentWeightLabel.text = String(format: "%.2f", element.convertTo(unit))
    }
}
