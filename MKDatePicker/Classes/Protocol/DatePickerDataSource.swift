//
//  PickerViewControllerDataSource.swift
//  XBDatePicker_Example
//
//  Created by xiaobin liu on 2020/3/26.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit


/// MARK - DatePickerDataSource
public protocol DatePickerDataSource: NSObjectProtocol {
    
    /// 初始化数据
    /// - Parameter contentView: DatePicker
    func initData(_ contentView: DatePicker)
    
    /// 默认选择
    ///
    /// - Parameter contentView: contentView description
    /// - Returns: return value description
    func pickerDefaultSelected(_ contentView: DatePicker)
    
    
    /// 每列多少个
    ///
    /// - Parameters:
    ///   - contentView: contentView description
    ///   - component: component description
    /// - Returns: return value description
    func pickerContentView(_ contentView: DatePicker, numberOfRowsInComponent component: Int) -> Int

    
    /// 每列宽度是多少
    ///
    /// - Parameters:
    ///   - pickerView: pickerView description
    ///   - component: component description
    /// - Returns: return value description
    func pickerContentView(_ contentView: DatePicker, widthForComponent component: Int) -> CGFloat
    
    
    /// 每一列展示的内容
    ///
    /// - Parameters:
    ///   - contentView: contentView description
    ///   - row: row description
    ///   - component: component description
    /// - Returns: return value description
    func pickerContentView(_ contentView: DatePicker, titleForRow row: Int, forComponent component: Int) -> String
}

