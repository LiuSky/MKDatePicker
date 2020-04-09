//
//  PickerViewController+Year.swift
//  XBDatePicker
//
//  Created by xiaobin liu on 2020/3/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit


/// MARK - PickerViewController + Year
extension PickerViewController {
    
    /// MARK - 年
    final class Year: NSObject {}
}


/// MARK - PickerViewControllerDataSource
extension PickerViewController.Year: PickerViewControllerDataSource {
    
    /// 初始化数据
    /// - Parameter contentView: <#contentView description#>
    public func initData(_ contentView: PickerViewController) {
        
        contentView.calculateYearList()
        guard let temSelectDate = contentView.selectDate else {
            return
        }
        contentView.calculateYearIndex(temSelectDate)
    }
    
    /// 默认选中
    public func pickerDefaultSelected(_ contentView: PickerViewController) {
        contentView.selectRow(contentView.yearIndex, inComponent: 0, animated: true)
    }
    
    
    /// 选择器宽度
    /// - Parameters:
    ///   - contentView: contentView
    ///   - component: component
    public func pickerContentView(_ contentView: PickerViewController, widthForComponent component: Int) -> CGFloat {
        return UIScreen.main.bounds.size.width
    }
    
    
    /// 每列多少个
    ///
    /// - Parameters:
    ///   - contentView: contentView description
    ///   - component: component description
    /// - Returns: return value description
    public func pickerContentView(_ contentView: PickerViewController, numberOfRowsInComponent component: Int) -> Int {
        return contentView.yearList.count
    }
    
    
    /// 每一列展示的内容
    ///
    /// - Parameters:
    ///   - contentView: contentView description
    ///   - row: row description
    ///   - component: component description
    /// - Returns: return value description
    public func pickerContentView(_ contentView: PickerViewController, titleForRow row: Int, forComponent component: Int) -> String {
        return contentView.yearList[row].name
    }
}

/// MARK - PickerViewControllerDelegate
extension PickerViewController.Year: PickerViewControllerDelegate {
    
    /// 选中索引
    ///
    /// - Parameters:
    ///   - contentView: contentView description
    ///   - row: row description
    ///   - component: component description
    public func pickerContentView(_ contentView: PickerViewController, didSelectRow row: Int, inComponent component: Int) {
        contentView.yearIndex = row
    }
    
    /// 获取日期字符串
    ///
    /// - Parameters:
    ///   - contentView: contentView description
    ///   - row: row description
    ///   - component: component description
    func pickerContentView(_ contentView: PickerViewController) -> String {
        return "\(contentView.yearList[contentView.yearIndex].id)"
    }
}
