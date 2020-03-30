//
//  PickerViewController+Time.swift
//  XBDatePicker
//
//  Created by xiaobin liu on 2020/3/26.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

/// MARK - PickerViewController + Time
extension PickerViewController {
    
    /// Time
    final class Time: NSObject {}
}


/// MARK - PickerViewControllerDataSource
extension PickerViewController.Time: PickerViewControllerDataSource {
    
    /// 初始化
    /// - Parameter contentView: <#contentView description#>
    public func initData(_ contentView: PickerViewController) {
        
        contentView.calculateHoursList()
        guard let temSelectDate = contentView.selectDate else {
            contentView.calculateMinuteList()
            return
        }
        
        do {
            
            contentView.calculateHoursIndex(temSelectDate)
            contentView.calculateMinuteList()
            contentView.calculateMinuteIndex(temSelectDate)
        }
    }
    
    /// 默认选中
    public func pickerDefaultSelected(_ contentView: PickerViewController) {
        contentView.selectRow(contentView.hoursIndex, inComponent: 0, animated: true)
        contentView.selectRow(contentView.minuteIndex, inComponent: 1, animated: true)
    }
    
    
    /// 选择器宽度
    /// - Parameters:
    ///   - contentView: contentView
    ///   - component: component
    public func pickerContentView(_ contentView: PickerViewController, widthForComponent component: Int) -> CGFloat {
        return 120
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
            return contentView.hoursList[row].name
        default:
            return contentView.minuteList[row].name
        }
    }
}

/// MARK - PickerViewControllerDelegate
extension PickerViewController.Time: PickerViewControllerDelegate {
    
    /// 选中索引
    ///
    /// - Parameters:
    ///   - contentView: contentView description
    ///   - row: row description
    ///   - component: component description
    public func pickerContentView(_ contentView: PickerViewController, didSelectRow row: Int, inComponent component: Int) {
        switch component {
        case 0:
            let minuteString = contentView.minuteList[contentView.minuteIndex].id
            contentView.hoursIndex = row
            
            do {
                /// 重新计算分数组以及索引
                contentView.calculateMinuteList()
                contentView.reloadComponent(1)
                
                contentView.minuteIndex = contentView.minuteList.firstIndex(of: PickerDateModel(id: minuteString, name: "")) ?? 0
                contentView.selectRow(contentView.minuteIndex, inComponent: 1, animated: false)
            }
        default:
            contentView.minuteIndex = row
        }
    }
}
