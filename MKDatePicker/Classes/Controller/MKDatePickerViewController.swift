//
//  MKDatePickerViewController.swift
//  Created on 2022/8/2
//  Description <#文件描述#>
//  PD <#产品文档地址#>
//  Design <#设计文档地址#>
//  Copyright © 2022 WZLY. All rights reserved.
//  @author 刘小彬(liuxiaomike@gmail.com)   
//

import UIKit
import XBAlertViewController

/// MARK - 默认控制器
open class MKDatePickerViewController: UIView {
    
    /// 取消回掉
    public let cancelCallBack = Delegate<DatePicker, Void>()
    
    /// 确定回掉
    public let confirmCallBack = Delegate<(DatePicker, Date), Void>()
    
    /// 默认头部视图高度为50
    public var headerViewHeight: CGFloat = 50
    
    /// 选择器
    public lazy var pickerView: DatePicker = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(DatePicker())
    
    /// 头部视图
    public lazy var headerView: PickerHeaderView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.delegate = self
        return $0
    }(PickerHeaderView())
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }
    
    required public init?(coder: NSCoder) {
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
            pickerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -safeAreaInsetsBottom),
        ])
    }
    
}


// MARK: - DateHeaderViewDelegate
extension MKDatePickerViewController: PickerHeaderViewDelegate {

    public func dateHeaderView(_ headerView: PickerHeaderView, cancel: UIButton) {

        cancelCallBack(self.pickerView)
        dismiss()
    }

    public func dateHeaderView(_ headerView: PickerHeaderView, confirm: UIButton) {

        confirmCallBack((self.pickerView, self.pickerView.selectDate!))
        dismiss()
    }
}


public extension MKDatePickerViewController {
    
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
