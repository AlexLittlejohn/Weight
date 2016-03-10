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
    
    let weightPicker = WeightCaptureView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        weightPicker.frame = view.bounds

        view.backgroundColor = .whiteColor()
        view.addSubview(weightPicker)

        
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
        

    }
    
    func save() {
        
//        guard let weightString = weightField.text where weightString.length > 0 else {
//            return
//        }
//        
//        let formatter = NSNumberFormatter()
//        formatter.numberStyle = .DecimalStyle
//        guard let weightDouble = formatter.numberFromString(weightString)?.doubleValue else {
//            return
//        }
//        
//        let weight = Weight(weight: weightDouble, date: date)
//        let action = AddWeightAction(weight: weight)
//        
//        mainStore.dispatch(action)
//        
//        let navigateAction = SetRouteAction([WeightViewController.identifier])
//        
//        mainStore.dispatch(navigateAction)
    }
}
