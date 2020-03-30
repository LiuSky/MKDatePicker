//
//  XBShowAlertView.swift
//  XBAlertViewController
//
//  Created by LiuSky on 03/19/2020.
//  Copyright (c) 2020 LiuSky. All rights reserved.
//

import UIKit


/// MARK - XBShowAlertViewDelegate
public protocol XBShowAlertViewDelegate: NSObjectProtocol {
    
    /// 将要展示
    func actionSheetWillShow(_ sheet: XBShowAlertView)
    /// 已经展示
    func actionSheetDidShow(_ sheet: XBShowAlertView)
    /// 将要隐藏
    func actionSheetWillDismiss(_ sheet: XBShowAlertView)
}


// MARK: - 协议扩展默认实现
extension XBShowAlertViewDelegate {
    
    func actionSheetWillShow(_ sheet: XBShowAlertView) { }
    func actionSheetDidShow(_ sheet: XBShowAlertView) { }
    func actionSheetWillDismiss(_ sheet: XBShowAlertView) { }
}


/// MARK - XBShowAlertView
public final class XBShowAlertView: UIView {
    
    /// 协议
    public weak var delegate: XBShowAlertViewDelegate?
    
    /// 背景视图
    internal lazy var backgroundView: UIView = {
        let temView = UIView()
        temView.alpha = 0.0
        temView.addGestureRecognizer(self.singleTap)
        return temView
    }()
    
    /// 点击手势
    private lazy var singleTap: UITapGestureRecognizer = {
        let temSingleTap = UITapGestureRecognizer(target: self, action: #selector(singleTap(sender:)))
        temSingleTap.isEnabled = backgoundTapDismissEnable
        return temSingleTap
    }()
    
    /// 背景点击隐藏是否启用(默认为false)
    public var backgoundTapDismissEnable: Bool = false {
        didSet {
            self.singleTap.isEnabled = backgoundTapDismissEnable
        }
    }
    
    /// 是否遮照
    public var isShowMask: Bool = true {
        didSet {
            if self.isShowMask {
                self.backgroundView.backgroundColor = UIColor.black.withAlphaComponent(0.25)
            } else {
                self.backgroundView.backgroundColor = UIColor.clear
            }
        }
    }
    
    /// 弹出风格
    public var alertStyle: XBAlertStyle = .alert(animateType: .scale(x: 0.0001, y: 0.0001))
    
    /// 默认显示为Y轴中心点(只对Alert样式有效)
    public var alertViewOriginY: CGFloat = 0
    
    /// 弹出视图边距(默认为: 0)
    public var alertViewEdging: CGFloat = 0
    
    /// 内容视图
    private(set) weak var contentView: UIView!
    /// 内容视图高度
    internal var contentViewHeight: CGFloat = 0
    /// 内容视图宽度
    internal var contentViewWidth: CGFloat = 0
    
    /// 初始化弹出视图
    ///
    /// - Parameter contentView: 内容视图
    public convenience init(contentView: UIView) {
        self.init(frame: CGRect.zero)
        self.contentView = contentView
        configView()
        configLocation()
    }
    
    private override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clear
        isUserInteractionEnabled = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    /// 手指点击事件
    @objc
    private func singleTap(sender: UITapGestureRecognizer) {
        dismiss()
    }
}
