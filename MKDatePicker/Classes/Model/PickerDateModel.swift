//
//  PickerDateModel.swift
//  XBDatePicker
//
//  Created by xiaobin liu on 2020/3/12.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation

/// MARK - 日期实体
public struct PickerDateModel {
    
    /// id
    let id: String

    /// 名称
    let name: String
    
    init(id: String, name: String) {
        self.id = id
        self.name = name
    }
}

/// MARK - Equatable
extension PickerDateModel: Equatable {
    
    public static func == (lhs: PickerDateModel, rhs: PickerDateModel) -> Bool {
        return lhs.id == rhs.id
    }
}
