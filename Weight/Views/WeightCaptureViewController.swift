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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gradient = CAGradientLayer()
        
        gradient.frame = gradientView.bounds
        gradient.colors = [UIColor.blackColor().CGColor, UIColor.blackColor().CGColor, UIColor.clearColor().CGColor]
        gradient.locations = [0.0, 0.65, 1.0]
        gradientView.layer.mask = gradient
        
        titleLabel.font = Typography.NavigationBar.Title.font
        titleLabel.textColor = Colors.NavigationBar.Title.color
    }
        
    @IBAction func confirm(sender: AnyObject) {
        guard let weight = weightPicker.getWeightValue() else {
            return
        }
        
        let action = AddWeightAction(weight: weight)
        let navigateAction = SetRouteAction([WeightViewController.identifier])
        
        mainStore.dispatch(action)
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
        
    }

}
