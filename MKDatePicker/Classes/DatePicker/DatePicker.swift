//
//  DatePicker.swift
//  MKDatePicker
//
//  Created by linjw on 2022/7/28.
//

import UIKit
import XBAlertViewController

/// 只有DatePicker这个View，没包含头部等信息
public class DatePicker: UIView {
    
    /// 协议
    internal typealias PickerViewProtocol = DatePickerDataSource & DatePickerDelegate
    
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
    
    
    /// 默认文本属性
    public var textAttributes: [NSAttributedString.Key : Any] = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 22), NSAttributedString.Key.foregroundColor: UIColor.black]
    
    /// 选中的富文本
    public var selectedAttributes: [NSAttributedString.Key : Any]? {
        didSet {
            pickerView.selectedAttributes = selectedAttributes
        }
    }
    
    /// 灰色的线
    public var lineColor: UIColor = UIColor(red: 183.0/255.0, green: 183.0/255.0, blue: 183.0/255.0, alpha: 1.0) {
        didSet {
            pickerView.lineColor = lineColor
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
    
    /// 周索引
    internal var weekIndex: Int = 0
    
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
    
    /// 年月日星期数组
    internal var dateWeekList: [PickerDateModel] = []
    
    /// 日期管理
    internal lazy var dateManager: PickerDateManager = {
        return $0
    }(PickerDateManager())
    
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
            case .dateWeekHourMinute:
                pickerViewProtocol = DateWeekHourMinute()
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
        addSubview(pickerView)
    }
    
    /// 配置位置
    private func configLocation() {
        
        NSLayoutConstraint.activate([
            pickerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            pickerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            pickerView.topAnchor.constraint(equalTo: topAnchor),
            pickerView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    /// 视图将要添加的时候
    /// - Parameter newSuperview: newSuperview
    public override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        if let _ = newSuperview {
            configView()
            configLocation()
        }
    }
    
    public func reloadDatas() {
        pickerViewProtocol.initData(self)
        pickerViewProtocol.pickerDefaultSelected(self)
    }
    
    public func currentSelectedDate() -> Date? {
        let dateText = pickerViewProtocol.pickerContentView(self)
        let date = Date(fromString: dateText, format: DateFormatType.custom(type.stringFormat))
       return date
    }
    
    open override var intrinsicContentSize: CGSize {
        return pickerView.intrinsicContentSize
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// MARK: - UIPickerViewDataSource
extension DatePicker: UIPickerViewDataSource {
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return type.section
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerViewProtocol.pickerContentView(self, numberOfRowsInComponent: component)
    }
}


// MARK: - UIPickerViewDelegate
extension DatePicker: UIPickerViewDelegate {
    
    public func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return pickerViewProtocol.pickerContentView(self, widthForComponent: component)
    }
    
    public func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return rowHeight
    }
    
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickerViewProtocol.pickerContentView(self, didSelectRow: row, inComponent: component)
        self.selectDate = currentSelectedDate()
    }
    
    public func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = UILabel()
        label.textAlignment = .center
        label.attributedText = NSAttributedString(string: pickerViewProtocol.pickerContentView(self, titleForRow: row, forComponent: component), attributes: textAttributes)
        return label
    }
}

// MARK: - extension
internal extension DatePicker {
    
    /// 选择行数
    ///
    /// - Parameters:
    ///   - row: row description
    ///   - component: component description
    ///   - animated: animated description
    func selectRow(_ row: Int, inComponent component: Int, animated: Bool) {
        let componentCount = pickerView.numberOfComponents
        if componentCount > component {
            let rowCount = pickerView.numberOfRows(inComponent: component)
            if rowCount > row {
                pickerView.selectRow(row, inComponent: component, animated: false)
            }
        }
    }
    
    
    /// 刷新Component
    ///
    /// - Parameter component: component description
    func reloadComponent(_ component: Int) {
        pickerView.reloadComponent(component)
    }
}
