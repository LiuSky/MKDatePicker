//
//  PickerViewControllerDelegate.swift
//  XBDatePicker_Example
//
//  Created by xiaobin liu on 2020/3/26.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit


/// MARK - DatePickerDelegate
public protocol DatePickerDelegate: NSObjectProtocol {
    
    /// 选中索引
    ///
    /// - Parameters:
    ///   - contentView: contentView description
    ///   - row: row description
    ///   - component: component description
    func pickerContentView(_ contentView: DatePicker, didSelectRow row: Int, inComponent component: Int)
    
    
    /// 获取日期字符串
    ///
    /// - Parameters:
    ///   - contentView: contentView description
    ///   - row: row description
    ///   - component: component description
    func pickerContentView(_ contentView: DatePicker) -> String
    
}

