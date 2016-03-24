//
//  LineChartView.swift
//  Weight
//
//  Created by Alex Littlejohn on 2016/03/20.
//  Copyright © 2016 Alex Littlejohn. All rights reserved.
//

import UIKit
import BEMSimpleLineGraph
import ReSwift

class LineChartView: UIView {

    let chart = BEMSimpleLineGraphView()
    
    var items = [Weight]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundColor = Colors.Chart.PopupBackground.color.lighten40()!
        chart.frame = bounds
        chart.dataSource = self
        chart.enablePopUpReport = true
        chart.formatStringForValues = "%.2f"
        chart.backgroundColor = Colors.Chart.Background.color
        chart.colorBottom = Colors.Chart.PopupBackground.color.lighten40()!
        chart.colorTop = Colors.Chart.Background.color
        chart.colorLine = Colors.Chart.Line.color
        chart.colorPoint = Colors.Chart.Circle.color
        chart.colorBackgroundPopUplabel = Colors.Chart.PopupBackground.color
        
        addSubview(chart)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        chart.reloadGraph()
    }
}

extension LineChartView: StoreSubscriber {
    func newState(state: AppState) {
        items = state.weights
        chart.reloadGraph()
    }
}

extension LineChartView: BEMSimpleLineGraphDataSource {
    func numberOfPointsInLineGraph(graph: BEMSimpleLineGraphView) -> Int {
        return items.count
    }
    
    func lineGraph(graph: BEMSimpleLineGraphView, valueForPointAtIndex index: Int) -> CGFloat {
        let value = items[index].weight
        return CGFloat(value)
    }
}