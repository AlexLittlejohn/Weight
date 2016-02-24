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
        
        goalTitleLabel.text = localizableString("goalTitleLabel")
        maxTitleLabel.text = localizableString("maxTitleLabel")
        minTitleLabel.text = localizableString("minTitleLabel")
        
        let units = localizableString("units.kilograms")
        
        currentUnitsLabel.text = units
        goalUnitsLabel.text = units
        maxUnitsLabel.text = units
        minUnitsLabel.text = units
        
        let button = UIBarButtonItem(image: UIImage(named: "AddWeightIcon")!.imageWithRenderingMode(.AlwaysOriginal), style: .Plain, target: self, action: "addWeight")
        
        navigationItem.rightBarButtonItem = button
    }
    
    func addWeight() {
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
        guard let element = weights.minElement({ $0.weight < $1.weight }) else {
            return
        }
        
        minLabel.text = "\(element.weight)"
    }
    
    func updateMaximums(weights: [Weight]) {
        guard let element = weights.maxElement({ $0.weight < $1.weight }) else {
            return
        }
        
        maxLabel.text = "\(element.weight)"
    }
    
    func updateGoal() {
        
    }
    
    func updateCurrent(weights: [Weight]) {
        guard let element = weights.maxElement({ $0.date > $1.date }) else {
            return
        }
        
        currentWeightLabel.text = "\(element.weight)"

    }
}
