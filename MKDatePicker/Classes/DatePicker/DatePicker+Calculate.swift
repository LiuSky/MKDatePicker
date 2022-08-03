//
//  DatePicker+Calculate.swift
//  XBDatePicker
//
//  Created by xiaobin liu on 2020/3/12.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

/// MARK - Calculate func
internal extension DatePicker {
    
    /// 计算年数组
    func calculateYearList() {
        yearList = dateManager.findYearList()
    }
    
    /// 计算月份数组
    func calculateMonthList() {
        
        switch type {
        case .year, .yearAndMonth, .date, .dateHour, .dateHourMinute, .dateHourMinuteSecond:
            let yearString = yearList[yearIndex].id
            let yearDate = Date(fromString: yearString, format: DateFormatType.custom("yyyy"))!
            monthList = dateManager.findCurrentMonth(date: yearDate)
        case .monthDay, .monthDayHour, .monthDayHourMinute, .monthDayHourMinuteSecond:
            monthList = dateManager.findCurrentMonth(date: Date())
        default:
            break
        }
    }
    
    
    /// 计算天数组
    func calculateDayList() {
        
        switch type {
        case .year, .yearAndMonth, .date, .dateHour, .dateHourMinute, .dateHourMinuteSecond:
            let yearAndMonth = yearList[yearIndex].id + "-" + monthList[monthIndex].id
            let yearAndMonthDate = Date(fromString: yearAndMonth, format: DateFormatType.custom("yyyy-MM"))!
            dayList = dateManager.findCurrentDay(date: yearAndMonthDate)
        case .monthDay, .monthDayHour, .monthDayHourMinute, .monthDayHourMinuteSecond:
            let month = monthList[monthIndex].id
            let monthDate = Date(fromString: month, format: DateFormatType.custom("MM"))!
            dayList = dateManager.findCurrentDay(date: monthDate)
        default:
            break
        }
    }
    
    
    /// 计算小时数组
    func calculateHoursList() {
        
        switch type {
        case .year, .yearAndMonth, .date, .dateHour, .dateHourMinute, .dateHourMinuteSecond:
            let dateString = yearList[yearIndex].id + "-" + monthList[monthIndex].id + "-" + dayList[dayIndex].id
            let date = Date(fromString: dateString, format: DateFormatType.custom("yyyy-MM-dd"))!
            hoursList = dateManager.findCurrentHours(date: date)
        case .monthDay, .monthDayHour, .monthDayHourMinute, .monthDayHourMinuteSecond:
            let dateString = monthList[monthIndex].id + "-" + dayList[dayIndex].id
            let date = Date(fromString: dateString, format: DateFormatType.custom("MM-dd"))!
            hoursList = dateManager.findCurrentHours(date: date)
        case .dateWeekHourMinute:
            let date = Date(fromString: dateWeekList[weekIndex].id, format: DateFormatType.custom("yyyy-MM-dd"))!
            hoursList = dateManager.findCurrentHours(date: date)
        default:
            let currentString = Date().toString(format: DateFormatType.custom("HH:mm"))
            hoursList = dateManager.findCurrentHours(date: Date(fromString: "\(currentString)", format: DateFormatType.custom("HH:mm"))!)
        }
    }
    
    /// 计算分数组
    func calculateMinuteList() {
        
        switch type {
        case .year, .yearAndMonth, .date, .dateHour, .dateHourMinute, .dateHourMinuteSecond:
            let dateString = yearList[yearIndex].id + "-" + monthList[monthIndex].id + "-" + dayList[dayIndex].id + " " + hoursList[hoursIndex].id
            let date = Date(fromString: dateString, format: DateFormatType.custom("yyyy-MM-dd HH"))!
            minuteList = dateManager.findCurrentMinute(date: date, steps: self.minuteSteps)
        case .monthDay, .monthDayHour, .monthDayHourMinute, .monthDayHourMinuteSecond:
            let dateString = monthList[monthIndex].id + "-" + dayList[dayIndex].id + " " + hoursList[hoursIndex].id
            let date = Date(fromString: dateString, format: DateFormatType.custom("MM-dd HH"))!
            minuteList = dateManager.findCurrentMinute(date: date, steps: self.minuteSteps)
        case .time, .timeAndSecond:
            let dateString = hoursList[hoursIndex].id
            let date = Date(fromString: dateString, format: DateFormatType.custom("HH"))!
            minuteList = dateManager.findCurrentMinute(date: date, steps: self.minuteSteps)
        case .dateWeekHourMinute:
            let date = Date(fromString: dateWeekList[weekIndex].id + " " + hoursList[hoursIndex].id, format: DateFormatType.custom("yyyy-MM-dd HH"))!
            minuteList = dateManager.findCurrentMinute(date: date, steps: self.minuteSteps)
        default:
            let currentString = Date().toString(format: DateFormatType.custom("mm:ss"))
            minuteList = dateManager.findCurrentMinute(date: Date(fromString: "\(currentString)", format: DateFormatType.custom("mm:ss"))!, steps: self.minuteSteps)
        }
    }
    
    /// 计算秒数组
    func calculateSecondList() {
        
        switch type {
        case .year, .yearAndMonth, .date, .dateHour, .dateHourMinute, .dateHourMinuteSecond:
            let dateString = yearList[yearIndex].id + "-" + monthList[monthIndex].id + "-" + dayList[dayIndex].id + " " + hoursList[hoursIndex].id + ":" + minuteList[minuteIndex].id
            let date = Date(fromString: dateString, format: DateFormatType.custom("yyyy-MM-dd HH:mm"))!
            secondList = dateManager.findCurrentSecond(date: date, steps: secondSteps)
        case .monthDay, .monthDayHour, .monthDayHourMinute, .monthDayHourMinuteSecond:
            let dateString = monthList[monthIndex].id + "-" + dayList[dayIndex].id + " " + hoursList[hoursIndex].id + ":" + minuteList[minuteIndex].id
            let date = Date(fromString: dateString, format: DateFormatType.custom("MM-dd HH:mm"))!
            secondList = dateManager.findCurrentSecond(date: date, steps: secondSteps)
        case .time, .timeAndSecond:
            let dateString = hoursList[hoursIndex].id + ":" + minuteList[minuteIndex].id
            let date = Date(fromString: dateString, format: DateFormatType.custom("HH:mm"))!
            secondList = dateManager.findCurrentSecond(date: date, steps: secondSteps)
        default:
            let dateString = minuteList[minuteIndex].id
            let date = Date(fromString: dateString, format: DateFormatType.custom("mm"))!
            secondList = dateManager.findCurrentSecond(date: date, steps: secondSteps)
        }
    }
    
    /// 计算日期星期列表
    func calculateDateWeakList() {
        
        let avg = dateManager.findMinDateAndMaxDate()
        let interval = dateManager.findIntervalDay(start: avg.min, end: avg.max)
        dateWeekList = []
        for item in (0...interval) {
            let new = Date(timeInterval: Date.dayInSeconds * Double(item), since: avg.min)
            let dateString = new.toString(format: DateFormatType.custom("yyyy-MM-dd"))
            dateWeekList.append(PickerDateModel(id: dateString, name: dateManager.dateConversion(new)))
        }
    }
    
    
    /// 计算年的索引
    func calculateYearIndex(_ date: Date) {
        
        let yearString = date.toString(format: DateFormatType.custom("yyyy"))
        yearIndex = yearList.firstIndex(of: PickerDateModel(id: yearString, name: "")) ?? 0
    }
    
    
    /// 计算月的索引
    /// - Parameter date: <#date description#>
    func calculateMonthIndex(_ date: Date) {
        
        let monthString = date.toString(format: DateFormatType.custom("MM"))
        monthIndex = monthList.firstIndex(of: PickerDateModel(id: monthString, name: "")) ?? 0
    }
    
    
    /// 计算天索引
    /// - Parameter date: <#date description#>
    func calculateDayIndex(_ date: Date) {
        
        let dayString = date.toString(format: DateFormatType.custom("dd"))
        dayIndex = dayList.firstIndex(of: PickerDateModel(id: dayString, name: "")) ?? 0
    }
    
    
    /// 计算小时索引
    /// - Parameter date: <#date description#>
    func calculateHoursIndex(_ date: Date) {
        
        let hoursString = date.toString(format: DateFormatType.custom("HH"))
        hoursIndex = hoursList.firstIndex(of: PickerDateModel(id: hoursString, name: "")) ?? 0
    }
    
    
    /// 计算分索引
    /// - Parameter date: <#date description#>
    func calculateMinuteIndex(_ date: Date) {
        let minuteString = date.toString(format: DateFormatType.custom("mm"))
        minuteIndex = minuteList.firstIndex(of: PickerDateModel(id: minuteString, name: "")) ?? 0
    }
    
    
    /// 计算秒索引
    /// - Parameter date: <#date description#>
    func calculateSecondIndex(_ date: Date) {
        
        let secondString = date.toString(format: DateFormatType.custom("ss"))
        secondIndex = secondList.firstIndex(of: PickerDateModel(id: secondString, name: "")) ?? 0
    }
    
    
    /// 计算日期周索引
    /// - Parameter date: date
    func calculateDateWeakIndex(_ date: Date) {
        let dateString = date.toString(format: DateFormatType.custom("yyyy-MM-dd"))
        weekIndex = dateWeekList.firstIndex(of: PickerDateModel(id: dateString, name: "")) ?? 0
    }
}
