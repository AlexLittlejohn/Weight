//
//  DateCaptureViewController.swift
//  Weight
//
//  Created by Alex Littlejohn on 2016/03/17.
//  Copyright © 2016 Alex Littlejohn. All rights reserved.
//

import UIKit
import ReSwift
import RSDayFlow

class DateCaptureViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var calendarView: RSDFDatePickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.font = Typography.NavigationBar.title.font
        titleLabel.textColor = Colors.NavigationBar.title.color
        
        calendarView.delegate = self
        calendarView.isPagingEnabled = true
    }
    
    @IBAction func confirm(_ sender: AnyObject) {

    }
    
    @IBAction func cancel(_ sender: AnyObject) {

    }
    
    @IBAction func scrollToToday(_ sender: AnyObject) {
        calendarView.scroll(toToday: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        calendarView.select(Date())
    }
}

extension DateCaptureViewController: RSDFDatePickerViewDelegate {
    func datePickerView(_ view: RSDFDatePickerView, shouldSelect date: Date) -> Bool {
        return Date().compare(date) == ComparisonResult.orderedDescending
    }
    
    func datePickerView(_ view: RSDFDatePickerView, didSelect date: Date) {
        mainStore.dispatch(Actions.setDate(date))
    }
}
