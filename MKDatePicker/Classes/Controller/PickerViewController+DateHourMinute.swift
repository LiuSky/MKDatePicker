//
//  PickerViewController+DateHourMinute.swift
//  XBDatePicker
//
//  Created by xiaobin liu on 2020/3/25.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

/// MARK - PickerViewController + DateHourMinute
extension PickerViewController {
    
    /// DateHourMinute
    final class DateHourMinute: NSObject {}
    
}

/// MARK - PickerViewControllerDataSource
extension PickerViewController.DateHourMinute: PickerViewControllerDataSource {
    
    
    /// 初始化
    /// - Parameter contentView: <#contentView description#>
    public func initData(_ contentView: PickerViewController) {
        
        contentView.calculateYearList()
        guard let temSelectDate = contentView.selectDate else {
            
            do {
                /// 初始化值
                contentView.calculateMonthList()
                contentView.calculateDayList()
                contentView.calculateHoursList()
                contentView.calculateMinuteList()
            }
            return
        }
        
        
        do {
            
            contentView.calculateYearIndex(temSelectDate)
            contentView.calculateMonthList()
            contentView.calculateMonthIndex(temSelectDate)
            contentView.calculateDayList()
            contentView.calculateDayIndex(temSelectDate)
            contentView.calculateHoursList()
            contentView.calculateHoursIndex(temSelectDate)
            contentView.calculateMinuteList()
            contentView.calculateMinuteIndex(temSelectDate)
        }
    }
    
    
    /// 默认选中
    public func pickerDefaultSelected(_ contentView: PickerViewController) {
        contentView.selectRow(contentView.yearIndex, inComponent: 0, animated: true)
        contentView.selectRow(contentView.monthIndex, inComponent: 1, animated: true)
        contentView.selectRow(contentView.dayIndex, inComponent: 2, animated: true)
        contentView.selectRow(contentView.hoursIndex, inComponent: 3, animated: true)
        contentView.selectRow(contentView.minuteIndex, inComponent: 4, animated: true)
    }
    
    
    /// 选择器宽度
    /// - Parameters:
    ///   - contentView: contentView
    ///   - component: component
    public func pickerContentView(_ contentView: PickerViewController, widthForComponent component: Int) -> CGFloat {
        if component == 0 {
            return 80
        } else {
            return 60
        }
    }
    
    
    /// 每列多少个
    ///
    /// - Parameters:
    ///   - contentView: contentView description
    ///   - component: component description
    /// - Returns: return value description
    public func pickerContentView(_ contentView: PickerViewController, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return contentView.yearList.count
        case 1:
            return contentView.monthList.count
        case 2:
            return contentView.dayList.count
        case 3:
            return contentView.hoursList.count
        default:
            return contentView.minuteList.count
        }
    }
    
    
    /// 每一列展示的内容
    ///
    /// - Parameters:
    ///   - contentView: contentView description
    ///   - row: row description
    ///   - component: component description
    /// - Returns: return value description
    public func pickerContentView(_ contentView: PickerViewController, titleForRow row: Int, forComponent component: Int) -> String {
        switch component {
        case 0:
            return contentView.yearList[row].name
        case 1:
            return contentView.monthList[row].name
        case 2:
            return contentView.dayList[row].name
        case 3:
            return contentView.hoursList[row].name
        default:
            return contentView.minuteList[row].name
        }
    }
}

/// MARK - PickerViewControllerDelegate
extension PickerViewController.DateHourMinute: PickerViewControllerDelegate {
    
    /// 选中索引
    ///
    /// - Parameters:
    ///   - contentView: contentView description
    ///   - row: row description
    ///   - component: component description
    public func pickerContentView(_ contentView: PickerViewController, didSelectRow row: Int, inComponent component: Int) {
        switch component {
        case 0:
            let monthString = contentView.monthList[contentView.monthIndex].id
            let dayString = contentView.dayList[contentView.dayIndex].id
            let hoursString = contentView.hoursList[contentView.hoursIndex].id
            let minuteString = contentView.minuteList[contentView.minuteIndex].id
            contentView.yearIndex = row
            
            do {
                /// 重新计算月份数组以及索引
                contentView.calculateMonthList()
                contentView.reloadComponent(1)
                
                contentView.monthIndex = contentView.monthList.firstIndex(of: PickerDateModel(id: monthString, name: "")) ?? 0
                contentView.selectRow(contentView.monthIndex, inComponent: 1, animated: false)
            }
            
            do {
                
                /// 重新计算天数组以及索引
                contentView.calculateDayList()
                contentView.reloadComponent(2)
                contentView.dayIndex = contentView.dayList.firstIndex(of: PickerDateModel(id: dayString, name: "")) ?? 0
                contentView.selectRow(contentView.dayIndex, inComponent: 2, animated: false)
            }
            
            do {
                
                /// 重新计算小时数组以及索引
                contentView.calculateHoursList()
                contentView.reloadComponent(3)
                contentView.hoursIndex = contentView.hoursList.firstIndex(of: PickerDateModel(id: hoursString, name: "")) ?? 0
                contentView.selectRow(contentView.hoursIndex, inComponent: 3, animated: false)
            }
            
            do {
                
                /// 重新计算分数组以及索引
                contentView.calculateMinuteList()
                contentView.reloadComponent(4)
                contentView.minuteIndex = contentView.minuteList.firstIndex(of: PickerDateModel(id: minuteString, name: "")) ?? 0
                contentView.selectRow(contentView.minuteIndex, inComponent: 4, animated: false)
            }
            
        case 1:
            let dayString = contentView.dayList[contentView.dayIndex].id
            let hoursString = contentView.hoursList[contentView.hoursIndex].id
            let minuteString = contentView.minuteList[contentView.minuteIndex].id
            contentView.monthIndex = row
            
            do {
                
                /// 重新计算天数组以及索引
                contentView.calculateDayList()
                contentView.reloadComponent(2)
                contentView.dayIndex = contentView.dayList.firstIndex(of: PickerDateModel(id: dayString, name: "")) ?? 0
                contentView.selectRow(contentView.dayIndex, inComponent: 2, animated: false)
            }
            
            do {
                
                /// 重新计算小时数组以及索引
                contentView.calculateHoursList()
                contentView.reloadComponent(3)
                contentView.hoursIndex = contentView.hoursList.firstIndex(of: PickerDateModel(id: hoursString, name: "")) ?? 0
                contentView.selectRow(contentView.hoursIndex, inComponent: 3, animated: false)
            }
            
            do {
                
                /// 重新计算分数组以及索引
                contentView.calculateMinuteList()
                contentView.reloadComponent(4)
                contentView.minuteIndex = contentView.minuteList.firstIndex(of: PickerDateModel(id: minuteString, name: "")) ?? 0
                contentView.selectRow(contentView.minuteIndex, inComponent: 4, animated: false)
            }
        case 2:
            let hoursString = contentView.hoursList[contentView.hoursIndex].id
            let minuteString = contentView.minuteList[contentView.minuteIndex].id
            contentView.dayIndex = row
            
            do {
                
                /// 重新计算小时数组以及索引
                contentView.calculateHoursList()
                contentView.reloadComponent(3)
                contentView.hoursIndex = contentView.hoursList.firstIndex(of: PickerDateModel(id: hoursString, name: "")) ?? 0
                contentView.selectRow(contentView.hoursIndex, inComponent: 3, animated: false)
            }
            
            do {
                
                /// 重新计算分数组以及索引
                contentView.calculateMinuteList()
                contentView.reloadComponent(4)
                contentView.minuteIndex = contentView.minuteList.firstIndex(of: PickerDateModel(id: minuteString, name: "")) ?? 0
                contentView.selectRow(contentView.minuteIndex, inComponent: 4, animated: false)
            }
            
        case 3:
            let minuteString = contentView.minuteList[contentView.minuteIndex].id
            contentView.hoursIndex = row
            
            do {
                contentView.calculateMinuteList()
                contentView.reloadComponent(4)
                contentView.minuteIndex = contentView.minuteList.firstIndex(of: PickerDateModel(id: minuteString, name: "")) ?? 0
                contentView.selectRow(contentView.minuteIndex, inComponent: 4, animated: false)
            }
        default:
            contentView.minuteIndex = row
        }
    }
}
