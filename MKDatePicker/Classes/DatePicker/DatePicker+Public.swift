//
//  DatePicker+Public.swift
//  XBDatePicker
//
//  Created by xiaobin liu on 2020/3/12.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import XBAlertViewController

/// MARK - public func
public extension DatePicker {
    
    /// 显示视图
    /// - Parameters:
    ///   - showInView: <#showInView description#>
    func show(showInView: UIView? = nil) {
        
        XBShowAlertView.showAlertView(alertStyle: XBAlertStyle.actionSheet(directionType: XBDirectionType.bottom),
                                      showInView: showInView,
                                      contentView: self,
                                      backgoundTapDismissEnable: false,
                                      isShowMask: true)
    }
    
    
    /// 隐藏
    func dismiss() {
        
        if let temView = superview as? XBShowAlertView {
            temView.dismiss()
        }
    }
}
