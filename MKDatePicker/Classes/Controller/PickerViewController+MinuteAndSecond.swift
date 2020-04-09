//
//  PickerViewController+MinuteAndSecond.swift
//  XBDatePicker
//
//  Created by xiaobin liu on 2020/3/26.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

/// MARK - PickerViewController + MinuteAndSecond
extension PickerViewController {
    
    /// MinuteAndSecond
    final class MinuteAndSecond: NSObject {}
}

/// MARK - PickerViewControllerDataSource
extension PickerViewController.MinuteAndSecond: PickerViewControllerDataSource {
    
    /// 初始化
    /// - Parameter contentView: <#contentView description#>
    public func initData(_ contentView: PickerViewController) {

        contentView.calculateMinuteList()
        guard let temSelectDate = contentView.selectDate else {
            contentView.calculateSecondList()
            return
        }
        
        do {

            contentView.calculateMinuteIndex(temSelectDate)
            contentView.calculateSecondList()
            contentView.calculateSecondIndex(temSelectDate)
        }
    }
    
    /// 默认选中
    public func pickerDefaultSelected(_ contentView: PickerViewController) {
        contentView.selectRow(contentView.minuteIndex, inComponent: 0, animated: true)
        contentView.selectRow(contentView.secondIndex, inComponent: 1, animated: true)
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
    public func pickerContentView(_ contentView: PickerViewController, titleForRow row: Int, forComponent component: Int) -> String {
        switch component {
        case 0:
            return contentView.minuteList[row].name
        default:
            return contentView.secondList[row].name
        }
    }
}

/// MARK - PickerViewControllerDelegate
extension PickerViewController.MinuteAndSecond: PickerViewControllerDelegate {
    
    /// 选中索引
    ///
    /// - Parameters:
    ///   - contentView: contentView description
    ///   - row: row description
    ///   - component: component description
    public func pickerContentView(_ contentView: PickerViewController, didSelectRow row: Int, inComponent component: Int) {
        switch component {
        case 0:
            
            let secondString = contentView.secondList[contentView.secondIndex].id
            contentView.minuteIndex = row
            do {
                
                /// 重新计算秒数组以及索引
                contentView.calculateSecondList()
                contentView.reloadComponent(1)
                contentView.secondIndex = contentView.secondList.firstIndex(of: PickerDateModel(id: secondString, name: "")) ?? 0
                contentView.selectRow(contentView.secondIndex, inComponent: 1, animated: false)
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
    func pickerContentView(_ contentView: PickerViewController) -> String {
        return "\(contentView.minuteList[contentView.minuteIndex].id):\(contentView.secondList[contentView.secondIndex].id)"
    }
}


