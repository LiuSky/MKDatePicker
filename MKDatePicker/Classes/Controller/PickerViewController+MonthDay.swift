//
//  PickerViewController+MonthDay.swift
//  XBDatePicker
//
//  Created by xiaobin liu on 2020/3/26.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit


/// MARK - PickerViewController + MonthDay
extension PickerViewController {
    
    /// MonthDay
    final class MonthDay: NSObject {}
}


/// MARK - PickerViewControllerDataSource
extension PickerViewController.MonthDay: PickerViewControllerDataSource {
        
    /// 初始化
    /// - Parameter contentView: contentView
    public func initData(_ contentView: PickerViewController) {
     
        contentView.calculateMonthList()
        guard let temSelectDate = contentView.selectDate else {
            do {
                contentView.calculateDayList()
            }
            return
        }
        
        do {
            contentView.calculateMonthIndex(temSelectDate)
            contentView.calculateDayList()
            contentView.calculateDayIndex(temSelectDate)
        }
    }
    
    /// 默认选中
    public func pickerDefaultSelected(_ contentView: PickerViewController) {
        contentView.selectRow(contentView.monthIndex, inComponent: 0, animated: true)
        contentView.selectRow(contentView.dayIndex, inComponent: 1, animated: true)
    }
    
    
    /// 选择器宽度
    /// - Parameters:
    ///   - contentView: contentView
    ///   - component: component
    public func pickerContentView(_ contentView: PickerViewController, widthForComponent component: Int) -> CGFloat {
        return 100
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
            return contentView.monthList.count
        default:
            return contentView.dayList.count
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
            return contentView.monthList[row].name
        default:
            return contentView.dayList[row].name
        }
    }
}
 
/// MARK - PickerViewControllerDelegate
extension PickerViewController.MonthDay: PickerViewControllerDelegate {
    
    /// 选中索引
    ///
    /// - Parameters:
    ///   - contentView: contentView description
    ///   - row: row description
    ///   - component: component description
    public func pickerContentView(_ contentView: PickerViewController, didSelectRow row: Int, inComponent component: Int) {
        switch component {
        case 0:
            
            let dayString = contentView.dayList[contentView.dayIndex].id
            contentView.monthIndex = row
            
            do {
                
                /// 重新计算天数组以及索引
                contentView.calculateDayList()
                contentView.reloadComponent(1)
                contentView.dayIndex = contentView.dayList.firstIndex(of: PickerDateModel(id: dayString, name: "")) ?? 0
                contentView.selectRow(contentView.dayIndex, inComponent: 1, animated: false)
            }
        default:
            contentView.dayIndex = row
        }
    }
    
    /// 获取日期字符串
    ///
    /// - Parameters:
    ///   - contentView: contentView description
    ///   - row: row description
    ///   - component: component description
    func pickerContentView(_ contentView: PickerViewController) -> String {
        return "\(contentView.monthList[contentView.monthIndex].id)-\(contentView.dayList[contentView.dayIndex].id)"
    }
}
