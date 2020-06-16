//
//  DateManager.swift
//  XBDatePicker
//
//  Created by xiaobin liu on 2020/3/12.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation

/// MARK - 日期管理
public class PickerDateManager {
    
    /// 时区
    public var timeZone: TimeZone = TimeZone.current {
        didSet {
            calendar.timeZone = timeZone
        }
    }
    
    /// 语言环境Locale
    public var locale: Locale = Locale.current {
        didSet {
            calendar.locale = locale
        }
    }
    
    /// 最小日期
    public var minimumDate: Date? {
        didSet {
            guard let temMinimumDate = minimumDate else {
                return
            }
            minimumComponents = calendar.dateComponents(unitFlags, from: temMinimumDate)
        }
    }
    
    /// 最大日期
    public var maximumDate: Date? {
        didSet {
            guard let temMaximumDate = maximumDate else {
                return
            }
            maximumComponents = calendar.dateComponents(unitFlags, from: temMaximumDate)
        }
    }
    
    /// 日历
    private lazy var calendar: Calendar = {
        var temCalendar = Calendar.current
        temCalendar.timeZone = self.timeZone
        temCalendar.locale = self.locale
        return temCalendar
    }()
    
    /// unitFlags
    private let unitFlags: Set<Calendar.Component> = [
        .year,
        .month,
        .day,
        .hour,
        .minute,
        .second,
        .weekday
    ]
    
    /// 日期最小组件
    private lazy var minimumComponents: DateComponents = {
        
        var temMinimumComponents: DateComponents!
        if let temMinimumDate = minimumDate {
            temMinimumComponents = self.calendar.dateComponents(unitFlags, from: temMinimumDate)
        } else {
            temMinimumComponents = self.calendar.dateComponents(unitFlags, from: Date.distantPast)
            temMinimumComponents.day = 1
            temMinimumComponents.month = 1
            temMinimumComponents.hour = 0
            temMinimumComponents.minute = 0
            temMinimumComponents.second = 0
        }
        return temMinimumComponents
    }()
    
    /// 日期最大组件
    private lazy var maximumComponents: DateComponents = {
        
        var temMaximumComponents: DateComponents!
        if let temMaximumDate = maximumDate {
            temMaximumComponents = self.calendar.dateComponents(unitFlags, from: temMaximumDate)
        } else {
            temMaximumComponents = self.calendar.dateComponents(unitFlags, from: Date.distantFuture)
            let range = Calendar.current.range(of: Calendar.Component.day, in: Calendar.Component.month, for: Date())!
            temMaximumComponents.day = range.upperBound - range.lowerBound
            temMaximumComponents.month = 12
            temMaximumComponents.hour = 23
            temMaximumComponents.minute = 59
            temMaximumComponents.second = 59
        }
        return temMaximumComponents
    }()
}

/// MARK - public func
extension PickerDateManager {
    
    /// 获取年份数组
    /// - Returns: 年份数组
    public func findYearList() -> [PickerDateModel] {
        
        guard let temMinimumYear = minimumComponents.year,
            let temMaximumYear = maximumComponents.year else {
                return []
        }
        
        return (temMinimumYear...temMaximumYear).map {
            PickerDateModel(id: "\($0)", name: "\($0)\("picker.year".localized())")
        }
    }
    
    /// 获取月份数组
    /// - Parameter date: 当前选中的日期
    /// - Returns: 月份数组
    public func findCurrentMonth(date: Date) -> [PickerDateModel] {
        
        var minimum = 1
        var maximum = 12
        
        guard let maxYear = maximumComponents.year,
            let minYear = minimumComponents.year,
            let selectedYear = date.component(DateComponentType.year),
            let maxMonth = maximumComponents.month,
            let minMonth = minimumComponents.month else {
                
                let array = (minimum...maximum).map { month -> PickerDateModel in
                    
                    if month < 10 {
                        return PickerDateModel(id: "0\(month)", name: "\(month)\("picker.month".localized())")
                    } else {
                        return PickerDateModel(id: "\(month)", name: "\(month)\("picker.month".localized())")
                    }
                }
                return array
        }
        
        if selectedYear == minYear {
            minimum = minMonth
        }
        
        if selectedYear == maxYear {
            maximum = maxMonth
        }
        
        if minYear == maxYear {
            minimum = minMonth
            maximum = maxMonth
        }
        
        
        let array = (minimum...maximum).map { month -> PickerDateModel in
            
            if month < 10 {
                return PickerDateModel(id: "0\(month)", name: "\(month)\("picker.month".localized())")
            } else {
                return PickerDateModel(id: "\(month)", name: "\(month)\("picker.month".localized())")
            }
        }
        return array
    }
    
    /// 获取天数数组
    /// - Parameter date: 当前选中的日期
    /// - Returns: 天数数组
    public func findCurrentDay(date: Date) -> [PickerDateModel] {
        
        var minimum = 1
        var maximum = date.numberOfDaysInMonth()
        
        guard let maxYear = maximumComponents.year,
            let minYear = minimumComponents.year,
            let selectedYear = date.component(DateComponentType.year),
            let selectedMonth = date.component(DateComponentType.month),
            let maxMonth = maximumComponents.month,
            let minMonth = minimumComponents.month,
            let maxDay = maximumComponents.day,
            let minDay = minimumComponents.day  else {
                
                let array = (minimum...maximum).map { day -> PickerDateModel in
                    if day < 10 {
                        return PickerDateModel(id: "0\(day)", name: "\(day)\("picker.day".localized())")
                    } else {
                        return PickerDateModel(id: "\(day)", name: "\(day)\("picker.day".localized())")
                    }
                }
                return array
        }
        
        /// 最小的年份等于选中的年份 并且 最小的月份等于选择的年份
        if minYear == selectedYear && minMonth == selectedMonth {
            minimum = minDay
        }
        
        /// 最大的年份等于选中的年份 并且 最大的月份等于选择的年份
        if maxYear == selectedYear && maxMonth == selectedMonth {
            maximum = maxDay
        }
        
        let array = (minimum...maximum).map { day -> PickerDateModel in
            if day < 10 {
                return PickerDateModel(id: "0\(day)", name: "\(day)\("picker.day".localized())")
            } else {
                return PickerDateModel(id: "\(day)", name: "\(day)\("picker.day".localized())")
            }
        }
        return array
    }
    
    /// 获取小时数组
    /// - Parameter date: 当前选中的日期
    /// - Returns: 小时数组
    public func findCurrentHours(date: Date) -> [PickerDateModel] {
        
        var minimum = 0
        var maximum = 23
        
        guard let selectedYear = date.component(DateComponentType.year),
            let selectedMonth = date.component(DateComponentType.month),
            let selectedDay = date.component(DateComponentType.day),
            let maxYear = maximumComponents.year,
            let minYear = minimumComponents.year,
            let maxMonth = maximumComponents.month,
            let minMonth = minimumComponents.month,
            let maxDay = maximumComponents.day,
            let minDay = minimumComponents.day,
            let maxHours = maximumComponents.hour,
            let minHours = minimumComponents.hour else {
                
                let array = (minimum...maximum).map { hours -> PickerDateModel in
                    if hours < 10 {
                        return PickerDateModel(id: "0\(hours)", name: "\(hours)\("picker.hours".localized())")
                    } else {
                        return PickerDateModel(id: "\(hours)", name: "\(hours)\("picker.hours".localized())")
                    }
                }
                return array
        }
        
        /// 最小的年份等于选中的年份 并且 最小的月份等于选择的年份
        if minYear == selectedYear && minMonth == selectedMonth && minDay == selectedDay {
            minimum = minHours
        }
        
        /// 最大的年份等于选中的年份 并且 最大的月份等于选择的年份
        if maxYear == selectedYear && maxMonth == selectedMonth && maxDay == selectedDay {
            maximum = maxHours
        }
        
        let array = (minimum...maximum).map { hours -> PickerDateModel in
            if hours < 10 {
                return PickerDateModel(id: "0\(hours)", name: "\(hours)\("picker.hours".localized())")
            } else {
                return PickerDateModel(id: "\(hours)", name: "\(hours)\("picker.hours".localized())")
            }
        }
        return array
    }
    
    /// 获取分数组
    /// - Parameter date: 当前选中的日期
    /// - Returns: 分数组
    public func findCurrentMinute(date: Date) -> [PickerDateModel] {
        
        var minimum = 0
        var maximum = 59
        
        guard let selectedYear = date.component(DateComponentType.year),
            let selectedMonth = date.component(DateComponentType.month),
            let selectedDay = date.component(DateComponentType.day),
            let selectedHours = date.component(DateComponentType.hour),
            let maxYear = maximumComponents.year,
            let minYear = minimumComponents.year,
            let maxMonth = maximumComponents.month,
            let minMonth = minimumComponents.month,
            let maxDay = maximumComponents.day,
            let minDay = minimumComponents.day,
            let maxHours = maximumComponents.hour,
            let minHours = minimumComponents.hour,
            let maxMinute = maximumComponents.minute,
            let minMinute = minimumComponents.minute else {
                
                let array = (minimum...maximum).map { minute -> PickerDateModel in
                    if minute < 10 {
                        return PickerDateModel(id: "0\(minute)", name: "\(minute)\("picker.minute".localized())")
                    } else {
                        return PickerDateModel(id: "\(minute)", name: "\(minute)\("picker.minute".localized())")
                    }
                }
                return array
        }
        
        /// 最小的年份等于选中的年份 并且 最小的月份等于选择的年份
        if minYear == selectedYear && minMonth == selectedMonth && minDay == selectedDay && minHours == selectedHours {
            minimum = minMinute
        }
        
        /// 最大的年份等于选中的年份 并且 最大的月份等于选择的年份
        if maxYear == selectedYear && maxMonth == selectedMonth && maxDay == selectedDay && maxHours == selectedHours  {
            maximum = maxMinute
        }
        
        let array = (minimum...maximum).map { minute -> PickerDateModel in
            if minute < 10 {
                return PickerDateModel(id: "0\(minute)", name: "\(minute)\("picker.minute".localized())")
            } else {
                return PickerDateModel(id: "\(minute)", name: "\(minute)\("picker.minute".localized())")
            }
        }
        return array
    }
    
    /// 获取秒数组
    /// - Parameter date: 当前选中的日期
    /// - Returns: 秒数组
    public func findCurrentSecond(date: Date) -> [PickerDateModel] {
        
        var minimum = 0
        var maximum = 59
        
        guard let selectedYear = date.component(DateComponentType.year),
            let selectedMonth = date.component(DateComponentType.month),
            let selectedDay = date.component(DateComponentType.day),
            let selectedHours = date.component(DateComponentType.hour),
            let selectedMinute = date.component(DateComponentType.minute),
            let maxYear = maximumComponents.year,
            let minYear = minimumComponents.year,
            let maxMonth = maximumComponents.month,
            let minMonth = minimumComponents.month,
            let maxDay = maximumComponents.day,
            let minDay = minimumComponents.day,
            let maxHours = maximumComponents.hour,
            let minHours = minimumComponents.hour,
            let maxMinute = maximumComponents.minute,
            let minMinute = minimumComponents.minute,
            let maxSecond = maximumComponents.second,
            let minSecond = minimumComponents.second else {
                
                let array = (minimum...maximum).map { second -> PickerDateModel in
                    if second < 10 {
                        return PickerDateModel(id: "0\(second)", name: "\(second)\("picker.second".localized())")
                    } else {
                        return PickerDateModel(id: "\(second)", name: "\(second)\("picker.second".localized())")
                    }
                }
                return array
        }
        
        /// 最小的年份等于选中的年份 并且 最小的月份等于选择的年份
        if minYear == selectedYear && minMonth == selectedMonth && minDay == selectedDay && minHours == selectedHours && minMinute == selectedMinute {
            minimum = minSecond
        }
        
        /// 最大的年份等于选中的年份 并且 最大的月份等于选择的年份
        if maxYear == selectedYear && maxMonth == selectedMonth && maxDay == selectedDay && maxHours == selectedHours && maxMinute == selectedMinute {
            maximum = maxSecond
        }
        
        let array = (minimum...maximum).map { second -> PickerDateModel in
            if second < 10 {
                return PickerDateModel(id: "0\(second)", name: "\(second)\("picker.second".localized())")
            } else {
                return PickerDateModel(id: "\(second)", name: "\(second)\("picker.second".localized())")
            }
        }
        return array
    }
    
    
    /// 获取最小日期和最大日期
    /// - Returns: 最小日期和最大日期
    public func findMinDateAndMaxDate() -> (min: Date, max: Date) {
        guard let min = minimumDate,
              let max = maximumDate else {
                
                let year = Date().toString(format: DateFormatType.custom("yyyy"))
                let minDate = Date(fromString: "\(year)-01-01 00:00", format: DateFormatType.custom("yyyy-MM-dd HH:mm"))
                let maxDay = Date(fromString: "\(year)-12", format: DateFormatType.custom("yyyy-MM"))!.numberOfDaysInMonth()
                let maxDate = Date(fromString: "\(year)-12-\(maxDay) 23:59", format: DateFormatType.custom("yyyy-MM-dd HH:mm"))
                return (min: minDate!, max: maxDate!)
        }
        return (min: min, max: max)
    }
    
    
    /// 获取间隔日期
    /// - Parameters:
    ///   - start: 开始日期
    ///   - end: 结束日期
    /// - Returns: 间隔天数
    public func findIntervalDay(start: Date, end: Date) -> Int {
        
        let delta = calendar.dateComponents([.day], from: start, to: end)
        return delta.day ?? 0
    }
    
    
    /// 获取星期几
    /// - Parameter data: 日期
    /// - Returns: 周几
    public func weekDay(data: Date) -> String {
        
        if let index = data.component(DateComponentType.weekday) {
            let weakDay = ["picker.sunday".localized(),
                           "picker.monday".localized(),
                           "picker.tuesday".localized(),
                           "picker.wednesday".localized(),
                           "picker.thursday".localized(),
                           "picker.friday".localized(),
                           "picker.saturday".localized()][index-1]
            return weakDay
        }
        return ""
    }
    
    
    /// 日期转换
    /// - Parameter string: yyyy-MM-dd
    /// - Returns: 显示的日期
    public func dateConversion(_ date: Date) -> String {
        
        if date.compare(DateComparisonType.isToday) {
            return "picker.toDay".localized()
        } else {
            return  date.toString(format: DateFormatType.custom("MM\("picker.month".localized())dd\("picker.day".localized())")) + " " + weekDay(data: date)
        }
    }
    
}
