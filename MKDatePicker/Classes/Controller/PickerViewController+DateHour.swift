//
//  PickerViewController+DateHour.swift
//  XBDatePicker
//
//  Created by xiaobin liu on 2020/3/24.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit


/// MARK - PickerViewController + DateHour
extension PickerViewController {
    
    /// DateHour
    final class DateHour: NSObject {}
}


/// MARK - PickerViewControllerDataSource
extension PickerViewController.DateHour: PickerViewControllerDataSource {
    
    
    /// 初始化
    /// - Parameter contentView: <#contentView description#>
    public func initData(_ contentView: PickerViewController) {
        
        contentView.calculateYearList()
        guard let temSelectDate = contentView.selectDate else {
            
            do {
                contentView.calculateMonthList()
                contentView.calculateDayList()
                contentView.calculateHoursList()
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
        }
    }
    
    
    /// 默认选中
    public func pickerDefaultSelected(_ contentView: PickerViewController) {
        contentView.selectRow(contentView.yearIndex, inComponent: 0, animated: true)
        contentView.selectRow(contentView.monthIndex, inComponent: 1, animated: true)
        contentView.selectRow(contentView.dayIndex, inComponent: 2, animated: true)
        contentView.selectRow(contentView.hoursIndex, inComponent: 3, animated: true)
    }
    
    
    /// 选择器宽度
    /// - Parameters:
    ///   - contentView: contentView
    ///   - component: component
    public func pickerContentView(_ contentView: PickerViewController, widthForComponent component: Int) -> CGFloat {
        return 80
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
    public func pickerContentView(_ contentView: PickerViewController, titleForRow row: Int, forComponent component: Int) -> String {
        switch component {
        case 0:
            return contentView.yearList[row].name
        case 1:
            return contentView.monthList[row].name
        case 2:
            return contentView.dayList[row].name
        default:
            return contentView.hoursList[row].name
        }
    }
}

/// MARK - PickerViewControllerDelegate
extension PickerViewController.DateHour: PickerViewControllerDelegate {
    
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
        case 1:
            let dayString = contentView.dayList[contentView.dayIndex].id
            let hoursString = contentView.hoursList[contentView.hoursIndex].id
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
        case 2:
            let hoursString = contentView.hoursList[contentView.hoursIndex].id
            contentView.dayIndex = row
            
            do {
                
                /// 重新计算小时数组以及索引
                contentView.calculateHoursList()
                contentView.reloadComponent(3)
                contentView.hoursIndex = contentView.hoursList.firstIndex(of: PickerDateModel(id: hoursString, name: "")) ?? 0
                contentView.selectRow(contentView.hoursIndex, inComponent: 3, animated: false)
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
    func pickerContentView(_ contentView: PickerViewController) -> String {
        return "\(contentView.yearList[contentView.yearIndex].id)-\(contentView.monthList[contentView.monthIndex].id)-\(contentView.dayList[contentView.dayIndex].id) \(contentView.hoursList[contentView.hoursIndex].id)"
    }
}
