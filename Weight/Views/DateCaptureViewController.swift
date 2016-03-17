//
//  DateCaptureViewController.swift
//  Weight
//
//  Created by Alex Littlejohn on 2016/03/17.
//  Copyright © 2016 Alex Littlejohn. All rights reserved.
//

import UIKit
import CVCalendar
import ReSwift
import ReSwiftRouter

class DateCaptureViewController: UIViewController, Routable {
    
    static let identifier = "DateCaptureViewController"

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var menuView: CVCalendarMenuView!
    @IBOutlet weak var calendarView: CVCalendarView!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.font = Typography.NavigationBar.Title.font
        titleLabel.textColor = Colors.NavigationBar.Title.color
        
        calendarView.calendarDelegate = self
        menuView.menuViewDelegate = self
    }
    
    @IBAction func confirm(sender: AnyObject) {
        
        let dateAction = SetDateAction(date: calendarView.manager.currentDate)
        let navigateAction = SetRouteAction([WeightCaptureViewController.identifier])
        
        mainStore.dispatch(dateAction)
        mainStore.dispatch(navigateAction)
    }
    
    @IBAction func cancel(sender: AnyObject) {
        let action = SetRouteAction([WeightCaptureViewController.identifier])
        mainStore.dispatch(action)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        calendarView.commitCalendarViewUpdate()
        menuView.commitMenuViewUpdate()
    }
}

extension DateCaptureViewController: CVCalendarViewDelegate {
    func presentationMode() -> CalendarMode {
        return .MonthView
    }
    
    func firstWeekday() -> Weekday {
        return .Sunday
    }
}

extension DateCaptureViewController: CVCalendarMenuViewDelegate {
    
}
