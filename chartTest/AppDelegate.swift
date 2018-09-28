//
//  AppDelegate.swift
//  chartTest
//
//  Created by Arik on 09/26/18.
//  Copyright © 2018 Arik. All rights reserved.
//

import Cocoa
import Charts

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    // ChartViewDelegate REMOVED what i added; that delegate for the click capture attempt
    @IBOutlet weak var pieChart: PieChartView!
    @IBOutlet weak var window: NSWindow!
    @IBOutlet weak var bottomInfoLabel: NSTextField!
//    @IBOutlet weak var percentLabel: NSTextField!
    @IBOutlet weak var percentButton: NSButton!
    @IBOutlet weak var clickHereButton: NSButton!
    
    var dataYes = PieChartDataEntry(value: 1)
    var dataNo = PieChartDataEntry(value: 0)
    var numberOfResponseEntries = [PieChartDataEntry]()
    var yesCount: Double = 1
    var noCount: Double = 0
    var percentButtonClickCount = 0
    var percentString = "placeholder %"
    var percentNumber = 100
    
    @objc func displayBottomInfoLabel() {
        bottomInfoLabel.stringValue = "Created by Arik"
    }


    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
//        pieChart.noDataText = "HAHHAHAHAHA"

        // add started at x time (current time)
        // add data i.e. number of clicks total weeeeeeeeee
        Timer.scheduledTimer(
            timeInterval: 2,
            target: self,
            selector: #selector(displayBottomInfoLabel),
            userInfo: nil,
            repeats: false)

        /// Makes window draggable from anywhere
        window.isMovableByWindowBackground = true

        /// Hides description
        pieChart.chartDescription?.text = ""
        /// Hides legend
        pieChart.legend.enabled = false
        /// Hides hole
//        pieChart.drawHoleEnabled = false
        pieChart.holeRadiusPercent = 0.6
        pieChart.holeColor = NSColor(named: NSColor.Name(rawValue: "holeColor"))
        
        /// Hides labels
        pieChart.drawEntryLabelsEnabled = false
//        pieChart.usePercentValuesEnabled = true

        dataYes.label = "Yes"
        dataNo.label = "No"

        numberOfResponseEntries = [dataNo, dataYes]
        
        updateChartData()
    }
    
    /// Updates pie chart
    func updateChartData() {
        percentNumber = Int(100 / ((yesCount + noCount) / yesCount))

//        var changingYesColor = CGFloat(Float(percentNumber + 800) / 1500)

        let blueHue = CGFloat(0.6)
        let changingSaturation = CGFloat(Float(percentNumber + 100) / 200)
        print(changingSaturation)
        // Change color from RED bad to PURPLE meh to BLUE good
        let chartDataSet = PieChartDataSet(values: numberOfResponseEntries, label: nil)
        let chartData = PieChartData(dataSet: chartDataSet)
        let colors = [NSColor(named: NSColor.Name(rawValue: "noColor")), NSColor.init(hue: blueHue, saturation: changingSaturation, brightness: 1, alpha: 1)]
        chartDataSet.colors = colors as! [NSUIColor]
        
        /// Hides values (numbers)
        chartDataSet.drawValuesEnabled = false
        /// Prevents chart from expanding on click
        chartDataSet.selectionShift = 0

        pieChart.animate(xAxisDuration: 1, yAxisDuration: 0.5)
        pieChart.data = chartData
        
        percentString = String(percentNumber) + "%"
//        percentLabel.stringValue = percentString
        updatePercentButton()
    }
    
    /// Updates percentage if it should be displayed
    func updatePercentButton() {
        if (percentButtonClickCount % 2) == 0 {
            percentButton.title = ""
        } else {
            percentButton.title = percentString
        }
    }
    
    @IBAction func percentButtonClick(_ sender: NSButton) {
        percentButtonClickCount += 1
        print(percentButtonClickCount)
        clickHereButton.isHidden = true
        updatePercentButton()
    }
    
    @IBAction func yesMenuClick(_ sender: Any) {
        yesCount += 1
        dataYes.value = yesCount
        updateChartData()
    }
    
    @IBAction func noMenuClick(_ sender: Any) {
        noCount += 1
        dataNo.value = noCount
        updateChartData()
    }
    
    @IBAction func yesClick(_ sender: NSButton) {
        yesCount += 1
        dataYes.value = yesCount
        updateChartData()
    }
    
    @IBAction func noClick(_ sender: NSButton) {
        noCount += 1
        dataNo.value = noCount
        updateChartData()
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
        pieChart.isHidden = true
    }


}

