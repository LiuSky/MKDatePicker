//
//  XBAlertAnimateType.swift
//  XBAlertViewController
//
//  Created by LiuSky on 03/19/2020.
//  Copyright (c) 2020 LiuSky. All rights reserved.
//

import UIKit
import Foundation


/// MARK - 方向类型
public enum XBDirectionType: Int, Equatable, CustomStringConvertible {
    
    case left
    case right
    case top
    case bottom
    
    
    /// 描述
    public var description: String {
        switch self {
        case .left:
            return "Left"
        case .right:
            return "Right"
        case .top:
            return "Top"
        case .bottom:
            return "Bottom"
        }
    }
}

/// MARK - 对话框动画类型
public enum XBAlertAnimateType: Equatable, CustomStringConvertible {
    
    case alpha(from: CGFloat , to: CGFloat)
    case scale(x: CGFloat , y: CGFloat)
    case direction(type: XBDirectionType)
    
    /// MARK - 描述
    public var description: String {
        switch self {
        case .alpha:
            return "Alpha"
        case .scale:
            return "Scale"
        case let .direction(type):
            return type.description
        }
    }
}


/// MARK - 弹出风格
public enum XBAlertStyle: Equatable, CustomStringConvertible {
    
    case alert(animateType: XBAlertAnimateType)
    case actionSheet(directionType: XBDirectionType)
    
    public static func == (lhs: XBAlertStyle, rhs: XBAlertStyle) -> Bool {
        switch (lhs, rhs) {
        case let  (.alert(lValue), .alert(rValue)):
            return lValue == rValue
        case let (.actionSheet(lValue), .actionSheet(rValue)):
            return lValue == rValue
        default:
            return false
        }
    }
    
    /// MARK - 描述
    public var description: String {
        switch self {
        case let .alert(animateType):
            return "Alert" + animateType.description
        case let .actionSheet(directionType):
            return "ActionSheet" + directionType.description
        }
    }
}


// MARK: - CaseIterable
extension XBAlertStyle: CaseIterable {

    public static var allCases: [XBAlertStyle] {
        return [XBAlertStyle.alert(animateType: XBAlertAnimateType.alpha(from: 0, to: 1)),
                XBAlertStyle.alert(animateType: XBAlertAnimateType.scale(x: 0.00001, y: 0.0001)),
                XBAlertStyle.alert(animateType: XBAlertAnimateType.direction(type: XBDirectionType.left)),
                XBAlertStyle.alert(animateType: XBAlertAnimateType.direction(type: XBDirectionType.right)),
                XBAlertStyle.alert(animateType: XBAlertAnimateType.direction(type: XBDirectionType.top)),
                XBAlertStyle.alert(animateType: XBAlertAnimateType.direction(type: XBDirectionType.bottom)),
                XBAlertStyle.actionSheet(directionType: XBDirectionType.left),
                XBAlertStyle.actionSheet(directionType: XBDirectionType.right),
                XBAlertStyle.actionSheet(directionType: XBDirectionType.top),
                XBAlertStyle.actionSheet(directionType: XBDirectionType.bottom)]
    }
}
