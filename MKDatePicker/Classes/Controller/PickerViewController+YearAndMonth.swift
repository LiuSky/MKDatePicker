//
//  PickerViewController+YearAndMonth.swift
//  XBDatePicker
//
//  Created by xiaobin liu on 2020/3/23.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit


/// MARK - PickerViewController + YearAndMonth
extension PickerViewController {
    
    /// 年月
    final class YearAndMonth: NSObject {}
}


/// MARK - PickerViewControllerDataSource
extension PickerViewController.YearAndMonth: PickerViewControllerDataSource {
    
    /// 初始化
    /// - Parameter contentView: <#contentView description#>
    public func initData(_ contentView: PickerViewController) {
        
        contentView.calculateYearList()
        
        guard let temSelectDate = contentView.selectDate else {
            contentView.calculateMonthList()
            return
        }
        contentView.calculateYearIndex(temSelectDate)
        contentView.calculateMonthList()
        contentView.calculateMonthIndex(temSelectDate)
    }
    
    /// 默认选中
    public func pickerDefaultSelected(_ contentView: PickerViewController) {
        contentView.selectRow(contentView.yearIndex, inComponent: 0, animated: true)
        contentView.selectRow(contentView.monthIndex, inComponent: 1, animated: true)
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
            return contentView.yearList.count
        default:
            return contentView.monthList.count
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
        default:
            return contentView.monthList[row].name
        }
    }
}

/// MARK - PickerViewControllerDelegate
extension PickerViewController.YearAndMonth: PickerViewControllerDelegate {
    
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
            contentView.yearIndex = row
            
            contentView.calculateMonthList()
            contentView.reloadComponent(1)
            
            //重新计算月份索引
            contentView.monthIndex = contentView.monthList.firstIndex(of: PickerDateModel(id: monthString, name: "")) ?? 0
            contentView.selectRow(contentView.monthIndex, inComponent: 1, animated: false)
        default:
            contentView.monthIndex = row
        }
    }
    
    /// 获取日期字符串
    ///
    /// - Parameters:
    ///   - contentView: contentView description
    ///   - row: row description
    ///   - component: component description
    func pickerContentView(_ contentView: PickerViewController) -> String {
        return "\(contentView.yearList[contentView.yearIndex].id)-\(contentView.monthList[contentView.monthIndex].id)"
    }
}
