//
//  DatePicker+MonthDayHour.swift
//  XBDatePicker
//
//  Created by xiaobin liu on 2020/3/26.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

/// MARK - DatePicker + MonthDayHour
extension DatePicker {
    
    /// MonthDayHour
    final class MonthDayHour: NSObject {}
}


/// MARK - DatePickerDataSource
extension DatePicker.MonthDayHour: DatePickerDataSource {
    
    /// 初始化
    /// - Parameter contentView: contentView
    public func initData(_ contentView: DatePicker) {
        
        contentView.calculateMonthList()
        guard let temSelectDate = contentView.selectDate else {
            
            do {
                contentView.calculateDayList()
                contentView.calculateHoursList()
            }
            return
        }
        
        do {
            
            contentView.calculateMonthIndex(temSelectDate)
            contentView.calculateDayList()
            contentView.calculateDayIndex(temSelectDate)
            contentView.calculateHoursList()
            contentView.calculateHoursIndex(temSelectDate)
        }
    }
    
    /// 默认选中
    public func pickerDefaultSelected(_ contentView: DatePicker) {
        contentView.selectRow(contentView.monthIndex, inComponent: 0, animated: true)
        contentView.selectRow(contentView.dayIndex, inComponent: 1, animated: true)
        contentView.selectRow(contentView.hoursIndex, inComponent: 2, animated: true)
    }
    
    
    /// 选择器宽度
    /// - Parameters:
    ///   - contentView: contentView
    ///   - component: component
    public func pickerContentView(_ contentView: DatePicker, widthForComponent component: Int) -> CGFloat {
        return 100
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
        default:
            return contentView.hoursList.count
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
        default:
            return contentView.hoursList[row].name
        }
    }
}

/// MARK - DatePickerDelegate
extension DatePicker.MonthDayHour: DatePickerDelegate {
    
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
        case 1:
            
            let hoursString = contentView.hoursList[contentView.hoursIndex].id
            contentView.dayIndex = row
            
            do {
                
                /// 重新计算小时数组以及索引
                contentView.calculateHoursList()
                contentView.reloadComponent(2)
                contentView.hoursIndex = contentView.hoursList.firstIndex(of: PickerDateModel(id: hoursString, name: "")) ?? 0
                contentView.selectRow(contentView.hoursIndex, inComponent: 2, animated: false)
            }
        default:
            contentView.hoursIndex = row
        }
    }
    
    /// 获取日期字符串
    ///
    /// - Parameters:
    ///   - contentView: contentView description
    ///   - row: row description
    ///   - component: component description
    func pickerContentView(_ contentView: DatePicker) -> String {
        return "\(contentView.monthList[contentView.monthIndex].id)-\(contentView.dayList[contentView.dayIndex].id) \(contentView.hoursList[contentView.hoursIndex].id)"
    }
}
