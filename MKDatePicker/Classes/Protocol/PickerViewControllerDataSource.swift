//
//  PickerViewControllerDataSource.swift
//  XBDatePicker_Example
//
//  Created by xiaobin liu on 2020/3/26.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit


/// MARK - PickerViewControllerDataSource
public protocol PickerViewControllerDataSource: NSObjectProtocol {
    
    /// 初始化数据
    /// - Parameter contentView: PickerViewController
    func initData(_ contentView: PickerViewController)
    
    /// 默认选择
    ///
    /// - Parameter contentView: contentView description
    /// - Returns: return value description
    func pickerDefaultSelected(_ contentView: PickerViewController)
    
    
    /// 每列多少个
    ///
    /// - Parameters:
    ///   - contentView: contentView description
    ///   - component: component description
    /// - Returns: return value description
    func pickerContentView(_ contentView: PickerViewController, numberOfRowsInComponent component: Int) -> Int

    
    /// 每列宽度是多少
    ///
    /// - Parameters:
    ///   - pickerView: pickerView description
    ///   - component: component description
    /// - Returns: return value description
    func pickerContentView(_ contentView: PickerViewController, widthForComponent component: Int) -> CGFloat
    
    
    /// 每一列展示的内容
    ///
    /// - Parameters:
    ///   - contentView: contentView description
    ///   - row: row description
    ///   - component: component description
    /// - Returns: return value description
    func pickerContentView(_ contentView: PickerViewController, titleForRow row: Int, forComponent component: Int) -> String
}

