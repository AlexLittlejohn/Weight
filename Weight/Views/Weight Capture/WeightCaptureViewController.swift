//
//  WeightCaptureViewController.swift
//  Weight
//
//  Created by Alex Littlejohn on 2016/02/20.
//  Copyright © 2016 Alex Littlejohn. All rights reserved.
//

import UIKit
import ReSwift

class WeightCaptureViewController: UIViewController, StoreSubscriber {
    @IBOutlet weak var weightPicker: WeightCaptureView!
    @IBOutlet weak var gradientView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gradient = CAGradientLayer()
        
        gradient.frame = gradientView.bounds
        gradient.colors = [UIColor.black.cgColor, UIColor.black.cgColor, UIColor.clear.cgColor]
        gradient.locations = [0.0, 0.65, 1.0]
        gradientView.layer.mask = gradient
        
        titleLabel.font = Typography.NavigationBar.title.font
        titleLabel.textColor = Colors.NavigationBar.title.color
        
        dateLabel.font = Typography.DateButton.title.font
        dateLabel.textColor = Colors.DateButton.title.color
        
        view.sendSubview(toBack: weightPicker)
    }
    
    @IBAction func changeDate(_ sender: AnyObject) {

    }
        
    @IBAction func confirm(_ sender: AnyObject) {
        guard let pickerValue = weightPicker.getValue() else {
            return
        }
        
        let date = mainStore.state?.captureDate ?? Date()
        let mode = mainStore.state?.captureMode ?? .weight
        let addAction = action(mode, weight: pickerValue.weight, unit: pickerValue.unit, date: date)

        mainStore.dispatch(addAction)
    }
    
    @IBAction func cancel(_ sender: AnyObject) {

    }

    override func viewWillAppear(_ animated: Bool) {
        mainStore.subscribe(self)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        mainStore.unsubscribe(self)
    }
    
    func newState(state: AppState) {
        configureTitle(state.captureMode, goal: state.goal != nil)
        configureDate(state.captureDate as Date)
    }
    
    func action(_ mode: CaptureMode, weight: Double, unit: Unit, date: Date) -> Action {
        if mode == .goal {
            let goal = Goal(weight: weight, unit:  unit)
            return Actions.addGoal(goal)
        } else {
            let w = Weight(weight: weight, date: date, unit: unit)
            return Actions.addWeight(w)
        }
    }
    
    func configureTitle(_ mode: CaptureMode, goal: Bool) {
        let title: String
        switch mode {
        case .weight:
            title = localizedString("addWeightTitle")
        case .goal:
            if goal {
                title = localizedString("changeGoalTitle")
            } else {
                title = localizedString("addGoalTitle")
            }
        }
        
        titleLabel.text = title
    }
    
    func configureDate(_ date: Date) {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM"
        
        dateLabel.text = formatter.string(from: date)
    }
}
