//
//  ViewController.swift
//  MKDatePicker
//
//  Created by LiuSky on 03/30/2020.
//  Copyright (c) 2020 LiuSky. All rights reserved.
//

import UIKit
import MKDatePicker

/// MARK - 自定义日期
final class ViewController: UIViewController {
    
    /// 列表
    private lazy var tableView: UITableView = {
        $0.dataSource = self
        $0.delegate = self
        $0.rowHeight = 50
        $0.tableFooterView = UIView()
        $0.separatorInset = .zero
        $0.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UITableView())
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "日期选择器Demo"
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

/// MARK - UITableViewDataSource
extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PickerDateType.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        cell.textLabel?.text = PickerDateType.allCases[indexPath.row].name
        return cell
    }
}

/// MARK - UITableViewDelegate
extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let type = PickerDateType.allCases[indexPath.row]
        
        let dfmatter = DateFormatter()
        var dateFormatType = DateFormatType.custom("yyyy-MM-dd")
        var minimumDate: Date? = nil
        var maximumDate: Date? = nil
        var selectDate: Date? = nil
        var headerTitle: String = ""
        var selectedAttributes: [NSAttributedString.Key : Any]?
        
        switch type {
        case .year:
            
            dfmatter.dateFormat = "yyyy"
            headerTitle = "选择年"
            dateFormatType = DateFormatType.custom("yyyy")
            minimumDate = Date()
            maximumDate = dfmatter.date(from: "2100")
            selectDate = dfmatter.date(from: "2021")
            selectedAttributes = [NSAttributedString.Key.foregroundColor : UIColor.red,
                                  NSAttributedString.Key.font: UIFont.systemFont(ofSize: 22, weight: UIFont.Weight.medium)]
        case .yearAndMonth:
            
            dfmatter.dateFormat = "yyyy-MM"
            headerTitle = "选择年月"
            dateFormatType = DateFormatType.custom("yyyy-MM")
            minimumDate = dfmatter.date(from: "1990-07")
            maximumDate = dfmatter.date(from: "2000-06")
            selectDate = dfmatter.date(from: "1990-08")
        case .date:
            
            dfmatter.dateFormat = "yyyy-MM-dd"
            headerTitle = "选择日期"
            dateFormatType = DateFormatType.custom("yyyy-MM-dd")
            minimumDate = dfmatter.date(from: "1990-07-21")
            maximumDate = dfmatter.date(from: "2000-08-21")
            selectDate = dfmatter.date(from: "1990-08-21")
        case .dateHour:
            
            dfmatter.dateFormat = "yyyy-MM-dd HH"
            headerTitle = "选择年月日时"
            dateFormatType = DateFormatType.custom("yyyy-MM-dd HH")
            minimumDate = dfmatter.date(from: "1990-07-21 01")
            maximumDate = dfmatter.date(from: "2000-08-21 22")
            selectDate = dfmatter.date(from: "1990-08-21 06")
        case .dateHourMinute:
            
            dfmatter.dateFormat = "yyyy-MM-dd HH:mm"
            headerTitle = "选择年月日时分"
            dateFormatType = DateFormatType.custom("yyyy-MM-dd HH:mm")
            minimumDate = dfmatter.date(from: "1990-07-21 01:10")
            maximumDate = dfmatter.date(from: "2000-08-21 22:55")
            selectDate = dfmatter.date(from: "1990-08-21 06:08")
        case .dateHourMinuteSecond:
            
            dfmatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            headerTitle = "选择年月日时分秒"
            dateFormatType = DateFormatType.custom("yyyy-MM-dd HH:mm:ss")
            minimumDate = dfmatter.date(from: "1990-07-21 01:10:02")
            maximumDate = dfmatter.date(from: "2000-08-21 22:55:58")
            selectDate = dfmatter.date(from: "1990-08-21 06:08:08")
        case .monthDay:
            
            dfmatter.dateFormat = "MM-dd"
            headerTitle = "选择月日"
            dateFormatType = DateFormatType.custom("MM-dd")
            minimumDate = dfmatter.date(from: "07-01")
            maximumDate = dfmatter.date(from: "08-21")
            selectDate = dfmatter.date(from: "08-21")
        case .monthDayHour:
            
            dfmatter.dateFormat = "MM-dd HH"
            headerTitle = "选择月日时"
            dateFormatType = DateFormatType.custom("MM-dd HH")
            minimumDate = dfmatter.date(from: "07-01 08")
            maximumDate = dfmatter.date(from: "08-21 22")
            selectDate = dfmatter.date(from: "08-21 08")
        case .monthDayHourMinute:
            
            dfmatter.dateFormat = "MM-dd HH:mm"
            headerTitle = "选择月日时分"
            dateFormatType = DateFormatType.custom("MM-dd HH:mm")
            selectDate = dfmatter.date(from: "08-21 08:08")
        case .monthDayHourMinuteSecond:
            
            dfmatter.dateFormat = "MM-dd HH:mm:ss"
            headerTitle = "选择月日时分秒"
            dateFormatType = DateFormatType.custom("MM-dd HH:mm:ss")
            minimumDate = dfmatter.date(from: "07-21 01:10:02")
            maximumDate = dfmatter.date(from: "11-21 22:55:58")
            selectDate = dfmatter.date(from: "08-21 06:08:08")
        case .time:
            
            dfmatter.dateFormat = "HH:mm"
            headerTitle = "选择时分"
            dateFormatType = DateFormatType.custom("HH:mm")
            minimumDate = dfmatter.date(from: "01:10")
            maximumDate = dfmatter.date(from: "22:55")
            selectDate = dfmatter.date(from: "06:08")
        case .timeAndSecond:
            
            dfmatter.dateFormat = "HH:mm:ss"
            headerTitle = "选择时分秒"
            dateFormatType = DateFormatType.custom("HH:mm:ss")
            minimumDate = dfmatter.date(from: "01:10:02")
            maximumDate = dfmatter.date(from: "22:55:34")
            selectDate = dfmatter.date(from: "06:08:08")
        case .minuteAndSecond:
            
            dfmatter.dateFormat = "mm:ss"
            headerTitle = "选择分秒"
            dateFormatType = DateFormatType.custom("mm:ss")
            minimumDate = dfmatter.date(from: "07:02")
            maximumDate = dfmatter.date(from: "55:34")
            selectDate = dfmatter.date(from: "08:08")
        case .dateWeekHourMinute:
            dfmatter.dateFormat = "yyyy-MM-dd HH:mm"
            headerTitle = "选择日期"
            dateFormatType = DateFormatType.custom("yyyy-MM-dd HH:mm")
            minimumDate = dfmatter.date(from: "2020-01-10 03:10")
            maximumDate = dfmatter.date(from: "2020-06-17 22:59")
            selectDate = Date()
        }
        
        let contentView = PickerViewController()
        contentView.type = type
        contentView.headerView.title = NSAttributedString(string: headerTitle, attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 16),
                                                                                 NSAttributedString.Key.foregroundColor: UIColor.black])
        contentView.selectDate = selectDate
        contentView.maximumDate = maximumDate
        contentView.minimumDate = minimumDate
        contentView.selectedAttributes = selectedAttributes
        contentView.confirmCallBack.delegate(on: self, block: { (weakSelf, arg1) in
            let (_, result) = arg1
            debugPrint(result.toString(format: dateFormatType))
        })
        contentView.cancelCallBack.delegate(on: self) { (weakSelf, view) in
            debugPrint(weakSelf)
        }
        contentView.show()
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
