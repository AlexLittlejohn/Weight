//
//  DateCaptureViewController.swift
//  Weight
//
//  Created by Alex Littlejohn on 2016/03/17.
//  Copyright © 2016 Alex Littlejohn. All rights reserved.
//

import UIKit
import ReSwift
import ReSwiftRouter
import RSDayFlow

class DateCaptureViewController: UIViewController, Routable {
    
    static let identifier = "DateCaptureViewController"

    @IBOutlet weak var titleLabel: UILabel!

    @IBOutlet weak var calendarView: RSDFDatePickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.font = Typography.NavigationBar.Title.font
        titleLabel.textColor = Colors.NavigationBar.Title.color
        
        calendarView.delegate = self
        calendarView.pagingEnabled = true
    }
    
    @IBAction func confirm(sender: AnyObject) {
        let action = SetRouteAction([WeightCaptureViewController.identifier])
        mainStore.dispatch(action)
    }
    
    @IBAction func cancel(sender: AnyObject) {
        let action = SetRouteAction([WeightCaptureViewController.identifier])
        mainStore.dispatch(action)
    }
    
    @IBAction func scrollToToday(sender: AnyObject) {
        calendarView.scrollToToday(true)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        calendarView.selectDate(NSDate())
    }
}

extension DateCaptureViewController: RSDFDatePickerViewDelegate {
    func datePickerView(view: RSDFDatePickerView!, shouldSelectDate date: NSDate!) -> Bool {
        return NSDate().compare(date) == NSComparisonResult.OrderedDescending
    }
    
    func datePickerView(view: RSDFDatePickerView!, didSelectDate date: NSDate!) {
        guard let date = date else {
            return
        }
        
        let action = SetDateAction(date: date)
        mainStore.dispatch(action)
    }
}
