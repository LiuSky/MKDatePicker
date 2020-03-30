//
//  DateHeaderView.swift
//  XBDatePicker
//
//  Created by xiaobin liu on 2020/3/12.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

/// MARK - PickerHeaderView协议
public protocol PickerHeaderViewDelegate: NSObjectProtocol {
    
    /// 取消事件
    /// - Parameters:
    ///   - headerView: DateHeaderView
    ///   - cancel: 取消按钮
    func dateHeaderView(_ headerView: PickerHeaderView, cancel: UIButton)
    
    
    /// 确定事件
    /// - Parameters:
    ///   - headerView: DateHeaderView
    ///   - confirm: 确定按钮
    func dateHeaderView(_ headerView: PickerHeaderView, confirm: UIButton)
}


/// MARK - 头部视图
public class PickerHeaderView: UIView {
    
    /// 协议
    weak public var delegate: PickerHeaderViewDelegate?
    
    /// 取消标题
    @objc public dynamic var cancelTitle = "headerView.cancel".localized() {
        didSet {
            self.cancelButton.setTitle(cancelTitle, for: .normal)
        }
    }
    
    /// 取消字体
    @objc public dynamic var cancelFont = UIFont.systemFont(ofSize: 16) {
        didSet {
            self.cancelButton.titleLabel?.font = cancelFont
        }
    }
    
    /// 取消按钮默认颜色
    @objc public dynamic var cancelNormalColor = UIColor(red: 170.0/255.0, green: 170.0/255.0, blue: 170.0/255.0, alpha: 1.0) {
        didSet {
            self.cancelButton.setTitleColor(cancelNormalColor, for: .normal)
        }
    }
    
    /// 取消按钮选中状态颜色
    @objc public dynamic var cancelHighlightedColor = UIColor(red: 170.0/255.0, green: 170.0/255.0, blue: 170.0/255.0, alpha: 1.0) {
        didSet {
            self.cancelButton.setTitleColor(cancelHighlightedColor, for: .highlighted)
        }
    }
    
    /// 确定标题
    @objc public dynamic var confirmTitle = "headerView.confirm".localized() {
        didSet {
            self.confirmButton.setTitle(confirmTitle, for: .normal)
        }
    }
    
    /// 确定按钮默认状态颜色
    @objc public dynamic var confirmNormalColor = UIColor.black {
        didSet {
            self.confirmButton.setTitleColor(confirmNormalColor, for: .normal)
        }
    }
    
    /// 确定按钮选中状态颜色
    @objc public dynamic var confirmHighlightedColor = UIColor.black {
        didSet {
            self.confirmButton.setTitleColor(confirmHighlightedColor, for: .highlighted)
        }
    }
    
    /// 确定字体
    @objc public dynamic var confirmFont = UIFont.systemFont(ofSize: 16) {
        didSet {
            self.confirmButton.titleLabel?.font = confirmFont
        }
    }
    
    /// 线的颜色
    @objc public dynamic var lineColor =  UIColor(red: 222/255.0, green: 224/255.0, blue: 226/255.0, alpha: 1.0) {
        didSet {
            self.topLine.backgroundColor = lineColor
            self.bottomLine.backgroundColor = lineColor
        }
    }
    
    /// 标题
    public var title: NSAttributedString? {
        didSet {
            self.titleLabel.attributedText = title
        }
    }
    
    /// 取消按钮
    private lazy var cancelButton: UIButton = {
        
        $0.titleLabel?.font = cancelFont
        $0.setTitle(cancelTitle, for: .normal)
        $0.setTitleColor(cancelNormalColor, for: .normal)
        $0.setTitleColor(cancelHighlightedColor, for: .highlighted)
        $0.addTarget(self, action: #selector(eventForCancel(_:)), for: .touchUpInside)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIButton(type: .custom))
    
    /// 标题
    private lazy var titleLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    /// 确定按钮
    private lazy var confirmButton: UIButton = {
        
        $0.titleLabel?.font = confirmFont
        $0.setTitle(confirmTitle, for: .normal)
        $0.setTitleColor(confirmNormalColor, for: .normal)
        $0.setTitleColor(confirmHighlightedColor, for: .highlighted)
        $0.addTarget(self, action: #selector(eventForConfirm(_:)), for: .touchUpInside)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIButton(type: .custom))
    
    
    /// 头部线
    private lazy var topLine: UILabel = {
        $0.backgroundColor = self.lineColor
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    /// 底部线
    private lazy var bottomLine: UILabel = {
        $0.backgroundColor = self.lineColor
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    
    /// 取消事件
    @objc
    private func eventForCancel(_ sender: UIButton) {
        
        delegate?.dateHeaderView(self, cancel: sender)
    }
    
    /// 确定事件
    @objc
    private func eventForConfirm(_ sender: UIButton) {
        delegate?.dateHeaderView(self, confirm: sender)
    }
    
    
    convenience init() {
        self.init(frame: CGRect.zero)
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        configView()
        configLocation()
    }
    
    
    /// 配置View
    private func configView() {
        
        addSubview(topLine)
        addSubview(cancelButton)
        addSubview(confirmButton)
        addSubview(titleLabel)
        addSubview(bottomLine)
    }
    
    /// 配置位置
    private func configLocation() {
        
        NSLayoutConstraint.activate([
            cancelButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 8),
            cancelButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            cancelButton.heightAnchor.constraint(greaterThanOrEqualToConstant: 30),
            cancelButton.widthAnchor.constraint(greaterThanOrEqualToConstant: 44),
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
        
        
        NSLayoutConstraint.activate([
            confirmButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -8),
            confirmButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            cancelButton.heightAnchor.constraint(greaterThanOrEqualToConstant: 30),
            cancelButton.widthAnchor.constraint(greaterThanOrEqualToConstant: 44),
        ])
        
        
        NSLayoutConstraint.activate([
            topLine.leftAnchor.constraint(equalTo: leftAnchor),
            topLine.rightAnchor.constraint(equalTo: rightAnchor),
            topLine.topAnchor.constraint(equalTo: topAnchor),
            topLine.heightAnchor.constraint(equalToConstant: 1.0 / UIScreen.main.scale),
        ])
        
        NSLayoutConstraint.activate([
            bottomLine.leftAnchor.constraint(equalTo: leftAnchor),
            bottomLine.rightAnchor.constraint(equalTo: rightAnchor),
            bottomLine.bottomAnchor.constraint(equalTo: bottomAnchor),
            bottomLine.heightAnchor.constraint(equalTo: topLine.heightAnchor),
        ])
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
