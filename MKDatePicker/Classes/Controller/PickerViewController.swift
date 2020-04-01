//
//  PickerViewController.swift
//  XBDatePicker
//
//  Created by xiaobin liu on 2020/3/12.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import XBAlertViewController


/// MARK - 选择器控制器
public final class PickerViewController: UIView {

    /// 协议
    internal typealias PickerViewProtocol = PickerViewControllerDataSource & PickerViewControllerDelegate
    
    /// 取消回掉
    public let cancelCallBack = Delegate<PickerViewController, Void>()
    
    /// 确定回掉
    public let confirmCallBack = Delegate<(PickerViewController, Date), Void>()
    
    /// 默认头部视图高度为50
    public var headerViewHeight: CGFloat = 50
    
    /// 默认行高
    public var rowHeight: CGFloat = 40
    
    /// 最小日期
    public var minimumDate: Date? {
        didSet {
            dateManager.minimumDate = minimumDate
        }
    }
       
    /// 最大日期
    public var maximumDate: Date? {
        didSet {
            dateManager.maximumDate = maximumDate
        }
    }
    
    /// 选择日期
    public var selectDate: Date?
    
    /// 选择器高度
    public var pickerViewHeight: CGFloat = 240
    
    /// 默认文本属性
    public var textAttributes: [NSAttributedString.Key : Any] = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 22), NSAttributedString.Key.foregroundColor: UIColor.black]
    
    /// 选中的富文本
    public var selectedAttributes: [NSAttributedString.Key : Any]? {
        didSet {
            pickerView.selectedAttributes = selectedAttributes
        }
    }
    
    /// 年索引
    internal var yearIndex: Int = 0
    
    /// 月索引
    internal var monthIndex: Int = 0
    
    /// 天的索引
    internal var dayIndex: Int = 0
    
    /// 小时索引
    internal var hoursIndex: Int = 0
    
    /// 分索引
    internal var minuteIndex: Int = 0
    
    /// 秒索引
    internal var secondIndex: Int = 0
    
    /// 年数组
    internal var yearList: [PickerDateModel] = []
    
    /// 月份数组
    internal var monthList: [PickerDateModel] = []
    
    /// 日数组
    internal var dayList: [PickerDateModel] = []
    
    /// 小时数组
    internal var hoursList: [PickerDateModel] = []
    
    /// 分数组
    internal var minuteList: [PickerDateModel] = []
    
    /// 秒数组
    internal var secondList: [PickerDateModel] = []
    
    /// 日期管理
    internal lazy var dateManager: PickerDateManager = {
        return $0
    }(PickerDateManager())
    
    
    /// 头部视图
    public private(set) lazy var headerView: PickerHeaderView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.delegate = self
        return $0
    }(PickerHeaderView())
    
    /// 选择器
    private lazy var pickerView: PickerView = {
        $0.delegate = self
        $0.dataSource = self
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(PickerView())
    
    /// 协议
    private var pickerViewProtocol: PickerViewProtocol = ISODate()
    
    /// 类型
    public var type: PickerDateType = .date {
        didSet {
            switch type {
            case .year:
                pickerViewProtocol = Year()
            case .yearAndMonth:
                pickerViewProtocol = YearAndMonth()
            case .date:
                pickerViewProtocol = ISODate()
            case .dateHour:
                pickerViewProtocol = DateHour()
            case .dateHourMinute:
                pickerViewProtocol = DateHourMinute()
            case .dateHourMinuteSecond:
                pickerViewProtocol = DateHourMinuteSecond()
            case .monthDay:
                pickerViewProtocol = MonthDay()
            case .monthDayHour:
                pickerViewProtocol = MonthDayHour()
            case .monthDayHourMinute:
                pickerViewProtocol = MonthDayHourMinute()
            case .monthDayHourMinuteSecond:
                pickerViewProtocol = MonthDayHourMinuteSecond()
            case .time:
                pickerViewProtocol = Time()
            case .timeAndSecond:
                pickerViewProtocol = TimeAndSecond()
            case .minuteAndSecond:
                pickerViewProtocol = MinuteAndSecond()
            }
        }
    }
    
    /// 初始化
    /// - Parameter combinationProtocol: combinationProtocol
    public convenience init() {
        self.init(frame: CGRect.zero)
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    /// 配置默认选择
    private func configDataSource() {
        pickerViewProtocol.initData(self)
        pickerViewProtocol.pickerDefaultSelected(self)
    }
    
    /// 配置视图
    private func configView() {
        backgroundColor = UIColor.white
        addSubview(headerView)
        addSubview(pickerView)
    }
    
    /// 配置位置
    private func configLocation() {
        
        var safeAreaInsetsBottom: CGFloat = 0
        if #available(iOS 11.0, *) {
            safeAreaInsetsBottom = UIApplication.shared.keyWindow?.rootViewController?.view.safeAreaInsets.bottom ?? 0
        }
        
        NSLayoutConstraint.activate([
            headerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            headerView.topAnchor.constraint(equalTo: topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: headerViewHeight),
        ])
        
        NSLayoutConstraint.activate([
            pickerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            pickerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            pickerView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            pickerView.heightAnchor.constraint(equalToConstant: pickerViewHeight),
            pickerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -safeAreaInsetsBottom),
        ])
    }
    
    /// 视图将要添加的时候
    /// - Parameter newSuperview: newSuperview
    public override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        if let _ = newSuperview {
            configView()
            configLocation()
            configDataSource()
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// MARK: - UIPickerViewDataSource
extension PickerViewController: UIPickerViewDataSource {
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return type.section
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerViewProtocol.pickerContentView(self, numberOfRowsInComponent: component)
    }
}


// MARK: - UIPickerViewDelegate
extension PickerViewController: UIPickerViewDelegate {
    
    public func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return pickerViewProtocol.pickerContentView(self, widthForComponent: component)
    }
    
    public func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return rowHeight
    }
    
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickerViewProtocol.pickerContentView(self, didSelectRow: row, inComponent: component)
    }
    
    public func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = UILabel()
        label.textAlignment = .center
        label.attributedText = NSAttributedString(string: pickerViewProtocol.pickerContentView(self, titleForRow: row, forComponent: component), attributes: textAttributes)
        return label
    }
}


// MARK: - DateHeaderViewDelegate
extension PickerViewController: PickerHeaderViewDelegate {
    
    public func dateHeaderView(_ headerView: PickerHeaderView, cancel: UIButton) {
        cancelCallBack(self)
        dismiss()
    }

    public func dateHeaderView(_ headerView: PickerHeaderView, confirm: UIButton) {
        
        var dateString: String!
        switch type {
        case .year:
            dateString = yearList[yearIndex].id
        case .yearAndMonth:
            dateString = "\(yearList[yearIndex].id)-\(monthList[monthIndex].id)"
        case .date:
            dateString = "\(yearList[yearIndex].id)-\(monthList[monthIndex].id)-\(dayList[dayIndex].id)"
        case .dateHour:
            dateString = "\(yearList[yearIndex].id)-\(monthList[monthIndex].id)-\(dayList[dayIndex].id) \(hoursList[hoursIndex].id)"
        case .dateHourMinute:
            dateString = "\(yearList[yearIndex].id)-\(monthList[monthIndex].id)-\(dayList[dayIndex].id) \(hoursList[hoursIndex].id):\(minuteList[minuteIndex].id)"
        case .dateHourMinuteSecond:
            dateString = "\(yearList[yearIndex].id)-\(monthList[monthIndex].id)-\(dayList[dayIndex].id) \(hoursList[hoursIndex].id):\(minuteList[minuteIndex].id):\(secondList[secondIndex].id)"
        case .monthDay:
            dateString = "\(monthList[monthIndex].id)-\(dayList[dayIndex].id)"
        case .monthDayHour:
            dateString = "\(monthList[monthIndex].id)-\(dayList[dayIndex].id) \(hoursList[hoursIndex].id)"
        case .monthDayHourMinute:
            dateString = "\(monthList[monthIndex].id)-\(dayList[dayIndex].id) \(hoursList[hoursIndex].id):\(minuteList[minuteIndex].id)"
        case .monthDayHourMinuteSecond:
            dateString = "\(monthList[monthIndex].id)-\(dayList[dayIndex].id) \(hoursList[hoursIndex].id):\(minuteList[minuteIndex].id):\(secondList[secondIndex].id)"
        case .time:
            dateString = "\(hoursList[hoursIndex].id):\(minuteList[minuteIndex].id)"
        case .timeAndSecond:
            dateString = "\(hoursList[hoursIndex].id):\(minuteList[minuteIndex].id):\(secondList[secondIndex].id)"
        case .minuteAndSecond:
            dateString = "\(minuteList[minuteIndex].id):\(secondList[secondIndex].id)"
        }
        let date = Date(fromString: dateString, format: DateFormatType.custom(type.stringFormat))!
        confirmCallBack((self, date))
        dismiss()
    }
}

// MARK: - public
internal extension PickerViewController {
    
    /// 选择行数
    ///
    /// - Parameters:
    ///   - row: row description
    ///   - component: component description
    ///   - animated: animated description
    func selectRow(_ row: Int, inComponent component: Int, animated: Bool) {
        
        pickerView.selectRow(row, inComponent: component, animated: false)
    }
    
    
    /// 刷新Component
    ///
    /// - Parameter component: component description
    func reloadComponent(_ component: Int) {
        pickerView.reloadComponent(component)
    }
}
