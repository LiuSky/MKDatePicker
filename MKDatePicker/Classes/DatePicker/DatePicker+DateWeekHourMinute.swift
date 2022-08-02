//
//  DatePicker+DateWeekHourMinute.swift
//  MKDatePicker
//
//  Created by xiaobin liu on 2020/6/15.
//

import UIKit

/// MARK - DatePicker + DateWeekHourMinute
extension DatePicker {
    
    /// 日期周时分
    final class DateWeekHourMinute: NSObject {}
}

/// MARK - DatePickerDataSource
extension DatePicker.DateWeekHourMinute: DatePickerDataSource {
    
    /// 初始化
    /// - Parameter contentView: contentView description
    public func initData(_ contentView: DatePicker) {
        
        contentView.calculateDateWeakList()
        guard let temSelectDate = contentView.selectDate else {
            
            do {
                contentView.calculateHoursList()
                contentView.calculateMinuteList()
            }
            return
        }
        
        do {
            contentView.calculateDateWeakIndex(temSelectDate)
            contentView.calculateHoursList()
            contentView.calculateHoursIndex(temSelectDate)
            contentView.calculateMinuteList()
            contentView.calculateMinuteIndex(temSelectDate)
        }
    }
    
    
    /// 默认选中
    public func pickerDefaultSelected(_ contentView: DatePicker) {
        contentView.selectRow(contentView.weekIndex, inComponent: 0, animated: true)
        contentView.selectRow(contentView.hoursIndex, inComponent: 1, animated: true)
        contentView.selectRow(contentView.minuteIndex, inComponent: 2, animated: true)
    }
    
    
    /// 选择器宽度
    /// - Parameters:
    ///   - contentView: contentView
    ///   - component: component
    public func pickerContentView(_ contentView: DatePicker, widthForComponent component: Int) -> CGFloat {
        if component == 0 {
            return 180
        } else {
            return 70
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
            return contentView.dateWeekList.count
        case 1:
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
    public func pickerContentView(_ contentView: DatePicker, titleForRow row: Int, forComponent component: Int) -> String {
        switch component {
        case 0:
            return contentView.dateWeekList[row].name
        case 1:
            return contentView.hoursList[row].name
        default:
            return contentView.minuteList[row].name
        }
    }
}

/// MARK - DatePickerDelegate
extension DatePicker.DateWeekHourMinute: DatePickerDelegate {
    
    /// 选中索引
    ///
    /// - Parameters:
    ///   - contentView: contentView description
    ///   - row: row description
    ///   - component: component description
    public func pickerContentView(_ contentView: DatePicker, didSelectRow row: Int, inComponent component: Int) {
        switch component {
        case 0:
            
            let hoursString = contentView.hoursList[contentView.hoursIndex].id
            let minuteString = contentView.minuteList[contentView.minuteIndex].id
            contentView.weekIndex = row
            do {
                
                /// 重新计算小时索引
                contentView.calculateHoursList()
                contentView.reloadComponent(1)
                contentView.hoursIndex = contentView.hoursList.firstIndex(of: PickerDateModel(id: hoursString, name: "")) ?? 0
                contentView.selectRow(contentView.hoursIndex, inComponent:1, animated: false)
            }
            
            do {
                
                /// 重新计算分索引
                contentView.calculateMinuteList()
                contentView.reloadComponent(2)
                contentView.minuteIndex = contentView.minuteList.firstIndex(of: PickerDateModel(id: minuteString, name: "")) ?? 0
                contentView.selectRow(contentView.minuteIndex, inComponent: 2, animated: false)
            }
            
        case 1:
            
            let minuteString = contentView.minuteList[contentView.minuteIndex].id
            contentView.hoursIndex = row
            
            do {
                /// 重新计算分索引
                contentView.calculateMinuteList()
                contentView.reloadComponent(2)
                contentView.minuteIndex = contentView.minuteList.firstIndex(of: PickerDateModel(id: minuteString, name: "")) ?? 0
                contentView.selectRow(contentView.minuteIndex, inComponent: 2, animated: false)
            }
        default:
            contentView.minuteIndex = row
        }
    }
    
    /// 获取日期字符串
    ///
    /// - Parameters:
    ///   - contentView: contentView description
    ///   - row: row description
    ///   - component: component description
    func pickerContentView(_ contentView: DatePicker) -> String {
        return "\(contentView.dateWeekList[contentView.weekIndex].id)" + " " + "\(contentView.hoursList[contentView.hoursIndex].id):\(contentView.minuteList[contentView.minuteIndex].id)"
    }
}
