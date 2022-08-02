//
//  DatePicker+MonthDayHourMinuteSecond.swift
//  XBDatePicker
//
//  Created by xiaobin liu on 2020/3/26.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

/// MARK - DatePicker + MonthDayHourMinuteSecond
extension DatePicker {
    
    /// MonthDayHourMinuteSecond
    final class MonthDayHourMinuteSecond: NSObject {}
}

/// MARK - DatePickerDataSource
extension DatePicker.MonthDayHourMinuteSecond: DatePickerDataSource {
    
    
    /// 初始化
    /// - Parameter contentView: <#contentView description#>
    public func initData(_ contentView: DatePicker) {
        
        contentView.calculateMonthList()
        guard let temSelectDate = contentView.selectDate else {
            
            do {
                /// 初始化值
                contentView.calculateDayList()
                contentView.calculateHoursList()
                contentView.calculateMinuteList()
                contentView.calculateSecondList()
            }
            return
        }
        
        
        do {
            
            contentView.calculateMonthIndex(temSelectDate)
            contentView.calculateDayList()
            contentView.calculateDayIndex(temSelectDate)
            contentView.calculateHoursList()
            contentView.calculateHoursIndex(temSelectDate)
            contentView.calculateMinuteList()
            contentView.calculateMinuteIndex(temSelectDate)
            contentView.calculateSecondList()
            contentView.calculateSecondIndex(temSelectDate)
        }
    }
    
    
    /// 默认选中
    public func pickerDefaultSelected(_ contentView: DatePicker) {
        contentView.selectRow(contentView.monthIndex, inComponent: 0, animated: true)
        contentView.selectRow(contentView.dayIndex, inComponent: 1, animated: true)
        contentView.selectRow(contentView.hoursIndex, inComponent: 2, animated: true)
        contentView.selectRow(contentView.minuteIndex, inComponent: 3, animated: true)
        contentView.selectRow(contentView.secondIndex, inComponent: 4, animated: true)
    }
    
    
    /// 选择器宽度
    /// - Parameters:
    ///   - contentView: contentView
    ///   - component: component
    public func pickerContentView(_ contentView: DatePicker, widthForComponent component: Int) -> CGFloat {
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
    public func pickerContentView(_ contentView: DatePicker, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return contentView.monthList.count
        case 1:
            return contentView.dayList.count
        case 2:
            return contentView.hoursList.count
        case 3:
            return contentView.minuteList.count
        default:
            return contentView.secondList.count
        }
    }
    
    
    /// 每一列展示的内容
    ///
    /// - Parameters:
    ///   - contentView: contentView description
    ///   - row: row description
    ///   - component: component description
    /// - Returns: return value description
    public func pickerContentView(_ contentView: DatePicker, titleForRow row: Int, forComponent component: Int) -> String {
        switch component {
        case 0:
            return contentView.monthList[row].name
        case 1:
            return contentView.dayList[row].name
        case 2:
            return contentView.hoursList[row].name
        case 3:
            return contentView.minuteList[row].name
        default:
            return contentView.secondList[row].name
        }
    }
}

/// MARK - DatePickerDelegate
extension DatePicker.MonthDayHourMinuteSecond: DatePickerDelegate {
    
    /// 选中索引
    ///
    /// - Parameters:
    ///   - contentView: contentView description
    ///   - row: row description
    ///   - component: component description
    public func pickerContentView(_ contentView: DatePicker, didSelectRow row: Int, inComponent component: Int) {
        switch component {
        case 0:
            let dayString = contentView.dayList[contentView.dayIndex].id
            let hoursString = contentView.hoursList[contentView.hoursIndex].id
            let minuteString = contentView.minuteList[contentView.minuteIndex].id
            let secondString = contentView.secondList[contentView.secondIndex].id
            contentView.monthIndex = row
            
            do {
                
                /// 重新计算天数组以及索引
                contentView.calculateDayList()
                contentView.reloadComponent(1)
                contentView.dayIndex = contentView.dayList.firstIndex(of: PickerDateModel(id: dayString, name: "")) ?? 0
                contentView.selectRow(contentView.dayIndex, inComponent: 1, animated: false)
            }
            
            do {
                
                /// 重新计算小时数组以及索引
                contentView.calculateHoursList()
                contentView.reloadComponent(2)
                contentView.hoursIndex = contentView.hoursList.firstIndex(of: PickerDateModel(id: hoursString, name: "")) ?? 0
                contentView.selectRow(contentView.hoursIndex, inComponent: 2, animated: false)
            }
            
            do {
                
                /// 重新计算分数组以及索引
                contentView.calculateMinuteList()
                contentView.reloadComponent(3)
                contentView.minuteIndex = contentView.minuteList.firstIndex(of: PickerDateModel(id: minuteString, name: "")) ?? 0
                contentView.selectRow(contentView.minuteIndex, inComponent: 3, animated: false)
            }
            
            do {
                
                /// 重新计算秒数组以及索引
                contentView.calculateSecondList()
                contentView.reloadComponent(4)
                contentView.secondIndex = contentView.secondList.firstIndex(of: PickerDateModel(id: secondString, name: "")) ?? 0
                contentView.selectRow(contentView.secondIndex, inComponent: 4, animated: false)
            }
        case 1:
            let hoursString = contentView.hoursList[contentView.hoursIndex].id
            let minuteString = contentView.minuteList[contentView.minuteIndex].id
            let secondString = contentView.secondList[contentView.secondIndex].id
            contentView.dayIndex = row
            
            do {
                
                /// 重新计算小时数组以及索引
                contentView.calculateHoursList()
                contentView.reloadComponent(2)
                contentView.hoursIndex = contentView.hoursList.firstIndex(of: PickerDateModel(id: hoursString, name: "")) ?? 0
                contentView.selectRow(contentView.hoursIndex, inComponent: 2, animated: false)
            }
            
            do {
                
                /// 重新计算分数组以及索引
                contentView.calculateMinuteList()
                contentView.reloadComponent(3)
                contentView.minuteIndex = contentView.minuteList.firstIndex(of: PickerDateModel(id: minuteString, name: "")) ?? 0
                contentView.selectRow(contentView.minuteIndex, inComponent: 3, animated: false)
            }
            
            do {
                
                /// 重新计算秒数组以及索引
                contentView.calculateSecondList()
                contentView.reloadComponent(4)
                contentView.secondIndex = contentView.secondList.firstIndex(of: PickerDateModel(id: secondString, name: "")) ?? 0
                contentView.selectRow(contentView.secondIndex, inComponent: 4, animated: false)
            }
        case 2:
            let minuteString = contentView.minuteList[contentView.minuteIndex].id
            let secondString = contentView.secondList[contentView.secondIndex].id
            contentView.hoursIndex = row
            
            do {
                
                /// 重新计算分数组以及索引
                contentView.calculateMinuteList()
                contentView.reloadComponent(3)
                contentView.minuteIndex = contentView.minuteList.firstIndex(of: PickerDateModel(id: minuteString, name: "")) ?? 0
                contentView.selectRow(contentView.minuteIndex, inComponent: 3, animated: false)
            }
            
            do {
                
                /// 重新计算秒数组以及索引
                contentView.calculateSecondList()
                contentView.reloadComponent(4)
                contentView.secondIndex = contentView.secondList.firstIndex(of: PickerDateModel(id: secondString, name: "")) ?? 0
                contentView.selectRow(contentView.secondIndex, inComponent: 4, animated: false)
            }
            
        case 3:
            let secondString = contentView.secondList[contentView.secondIndex].id
            contentView.minuteIndex = row
            
            do {
                
                /// 重新计算秒数组以及索引
                contentView.calculateSecondList()
                contentView.reloadComponent(4)
                contentView.secondIndex = contentView.secondList.firstIndex(of: PickerDateModel(id: secondString, name: "")) ?? 0
                contentView.selectRow(contentView.secondIndex, inComponent: 4, animated: false)
            }
        default:
            contentView.secondIndex = row
        }
    }
    
    /// 获取日期字符串
    ///
    /// - Parameters:
    ///   - contentView: contentView description
    ///   - row: row description
    ///   - component: component description
    func pickerContentView(_ contentView: DatePicker) -> String {
        return "\(contentView.monthList[contentView.monthIndex].id)-\(contentView.dayList[contentView.dayIndex].id) \(contentView.hoursList[contentView.hoursIndex].id):\(contentView.minuteList[contentView.minuteIndex].id):\(contentView.secondList[contentView.secondIndex].id)"
    }
}

