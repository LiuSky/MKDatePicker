//
//  PickerDateType.swift
//  XBDatePicker
//
//  Created by xiaobin liu on 2020/3/12.
//  Copyright © 2020 CocoaPods. All rights reserved.
//


import UIKit

/// MARK - 日期类型
public enum PickerDateType: Int, CaseIterable {
    
    case year
    case yearAndMonth
    case date
    case dateHour
    case dateHourMinute
    case dateHourMinuteSecond
    case monthDay
    case monthDayHour
    case monthDayHourMinute
    case monthDayHourMinuteSecond
    case time
    case timeAndSecond
    case minuteAndSecond
    case dateWeakHourMinute
    
    /// 名称
    public var name: String {
        switch self {
        case .year:
            return "年"
        case .yearAndMonth:
            return "年月"
        case .date:
            return "年月日"
        case .dateHour:
            return "年月日时"
        case .dateHourMinute:
            return "年月日时分"
        case .dateHourMinuteSecond:
            return "年月日时分秒"
        case .monthDay:
            return "月日"
        case .monthDayHour:
            return "月日时"
        case .monthDayHourMinute:
            return "月日时分"
        case .monthDayHourMinuteSecond:
            return "月日时分秒"
        case .time:
            return "时分"
        case .timeAndSecond:
            return "时分秒"
        case .minuteAndSecond:
            return "分秒"
        case .dateWeakHourMinute:
            return "年月周时分"
        }
    }
    
    
    /// MARK - 格式
    public var stringFormat: String {
        switch self {
        case .year:
            return "yyyy"
        case .yearAndMonth:
            return "yyyy-MM"
        case .date:
            return "yyyy-MM-dd"
        case .dateHour:
            return "yyyy-MM-dd HH"
        case .dateHourMinute:
            return "yyyy-MM-dd HH:mm"
        case .dateHourMinuteSecond:
            return "yyyy-MM-dd HH:mm:ss"
        case .monthDay:
            return "MM-dd"
        case .monthDayHour:
            return "MM-dd HH"
        case .monthDayHourMinute:
            return "MM-dd HH:mm"
        case .monthDayHourMinuteSecond:
            return "MM-dd HH:mm:ss"
        case .time:
            return "HH:mm"
        case .timeAndSecond:
            return "HH:mm:ss"
        case .minuteAndSecond:
            return "mm:ss"
        case .dateWeakHourMinute:
            return "yyyy-MM-dd HH:mm"
        }
    }
    
    
    /// MARK - 分组
    public var section: Int {
        switch self {
        case .year:
            return 1
        case .yearAndMonth:
            return 2
        case .date:
            return 3
        case .dateHour:
            return 4
        case .dateHourMinute:
            return 5
        case .dateHourMinuteSecond:
            return 6
        case .monthDay:
            return 2
        case .monthDayHour:
            return 3
        case .monthDayHourMinute:
            return 4
        case .monthDayHourMinuteSecond:
            return 5
        case .time:
            return 2
        case .timeAndSecond:
            return 3
        case .minuteAndSecond:
            return 2
        case .dateWeakHourMinute:
            return 3
        }
    }
}
