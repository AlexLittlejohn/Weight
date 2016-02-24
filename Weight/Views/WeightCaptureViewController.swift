//
//  WeightCaptureViewController.swift
//  Weight
//
//  Created by Alex Littlejohn on 2016/02/20.
//  Copyright © 2016 Alex Littlejohn. All rights reserved.
//

import UIKit
import ReSwiftRouter

class WeightCaptureViewController: UIViewController, Routable {
    
    static let identifier = "WeightCaptureViewController"
    
    let weightField = UITextField()
    let dateField = UITextField()
    let datePicker = UIDatePicker()
    
    let saveButton = UIButton()
    
    let store = NSUserDefaults.standardUserDefaults()
    
    var date = NSDate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dateField.text = store.valueForKey("date") as? String
        weightField.text = store.valueForKey("weight") as? String

        datePicker.datePickerMode = .Date
        datePicker.addTarget(self, action: "dateChange", forControlEvents: .ValueChanged)
        
        weightField.frame = CGRect(x: 40, y: 84, width: 200, height: 44)
        weightField.placeholder = "capture your weight"
        weightField.keyboardType = .DecimalPad
        
        dateField.frame = weightField.frame
        dateField.frame.origin.y += 60
        dateField.placeholder = "and the date!"
        dateField.inputView = datePicker
        
        saveButton.setTitle("Save", forState: .Normal)
        saveButton.frame = dateField.frame
        saveButton.frame.origin.y += 60
        saveButton.backgroundColor = .blueColor()
        saveButton.setTitleColor(.whiteColor(), forState: .Normal)
        saveButton.addTarget(self, action: "save", forControlEvents: .TouchUpInside)

        view.backgroundColor = .whiteColor()
        view.addSubview(weightField)
        view.addSubview(dateField)
        view.addSubview(saveButton)
        
        let button = UIBarButtonItem(image: UIImage(named: "NavigateBackArrow")!.imageWithRenderingMode(.AlwaysOriginal), style: .Plain, target: self, action: "goBack")
        
        navigationItem.leftBarButtonItem = button
    }
    
    func goBack() {
        let action = SetRouteAction([WeightViewController.identifier])
        mainStore.dispatch(action)
    }
    
    func dateChange() {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = .MediumStyle
        dateFormatter.timeStyle = .NoStyle
        
        date = datePicker.date
        
        dateField.text = dateFormatter.stringFromDate(datePicker.date)
    }
    
    func save() {
        
        guard let weightString = weightField.text where weightString.length > 0 else {
            return
        }
        
        let formatter = NSNumberFormatter()
        formatter.numberStyle = .DecimalStyle
        guard let weightDouble = formatter.numberFromString(weightString)?.doubleValue else {
            return
        }
        
        let weight = Weight(weight: weightDouble, date: date)
        let action = AddWeightAction(weight: weight)
        
        mainStore.dispatch(action)
        
        let navigateAction = SetRouteAction([WeightViewController.identifier])
        
        mainStore.dispatch(navigateAction)
    }
}
