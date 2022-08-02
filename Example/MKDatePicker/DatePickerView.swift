//
//  DatePickerView.swift
//  MKDatePicker_Example
//
//  Created by linjw on 2022/7/28.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit
import XBAlertViewController
import MKDatePicker

public class DatePickerView: UIView {
    
    /// 取消回掉
    public let cancelCallBack = Delegate<DatePicker, Void>()
    
    /// 确定回掉
    public let confirmCallBack = Delegate<(DatePicker, Date), Void>()
    
    /// 默认头部视图高度为50
    public var headerViewHeight: CGFloat = 50
    
    /// 选择器
    public lazy var pickerView: DatePicker = {
        let it = DatePicker()
        it.translatesAutoresizingMaskIntoConstraints = false
        return it
    }()
    
    public lazy var headerView: PickerHeaderView = {
        let it = PickerHeaderView()
        
        it.translatesAutoresizingMaskIntoConstraints = false
        it.delegate = self
        return it
    }()
    
//    /// 头部视图
//    public private(set) lazy var headerView: PickerHeaderView = {
//        $0.translatesAutoresizingMaskIntoConstraints = false
////        $0.delegate = self
//        return $0
//    }(PickerHeaderView())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        
        backgroundColor = .white
        
        addSubview(headerView)
        addSubview(pickerView)

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
//            pickerView.heightAnchor.constraint(equalToConstant: pickerViewHeight),
            pickerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -safeAreaInsetsBottom),
        ])
    }
    
//    public override func willMove(toSuperview newSuperview: UIView?) {
//        super.willMove(toSuperview: newSuperview)
//        if let _ = newSuperview {
//            setupUI()
//        }
//    }
    
}


// MARK: - DateHeaderViewDelegate
extension DatePickerView: PickerHeaderViewDelegate {

    public func dateHeaderView(_ headerView: PickerHeaderView, cancel: UIButton) {

        cancelCallBack(self.pickerView)
        dismiss()
    }

    public func dateHeaderView(_ headerView: PickerHeaderView, confirm: UIButton) {

//        let dateString = self.pickerViewpickerViewProtocol.pickerContentView(self.pickerView)
//        let date = Date(fromString: dateString, format: DateFormatType.custom(type.stringFormat))!
        confirmCallBack((self.pickerView, self.pickerView.selectDate!))
        dismiss()
    }
}


extension DatePickerView {
    
    /// 显示视图
    /// - Parameters:
    ///   - showInView: <#showInView description#>
    func show(showInView: UIView? = nil) {
        pickerView.reloadDatas()
        XBShowAlertView.showAlertView(alertStyle: XBAlertStyle.actionSheet(directionType: XBDirectionType.bottom),
                                      showInView: showInView,
                                      contentView: self,
                                      backgoundTapDismissEnable: true,
                                      isShowMask: true)
    }
    
    
    /// 隐藏
    func dismiss() {
        
        if let temView = superview as? XBShowAlertView {
            temView.dismiss()
        }
    }
}
