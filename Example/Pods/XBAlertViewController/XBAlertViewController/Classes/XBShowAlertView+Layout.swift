//
//  XBShowAlertView+Layout.swift
//  XBAlertViewController
//
//  Created by LiuSky on 03/19/2020.
//  Copyright (c) 2020 LiuSky. All rights reserved.
//

import UIKit
import Foundation


// MARK: - XBShowAlertView+Layout
extension XBShowAlertView {
    
    /// 配置视图
    internal func configView() {
        
        guard let contentView = self.contentView else {
            fatalError("内容视图不能为nil")
        }
        addSubview(contentView)
        insertSubview(backgroundView, at: 0)
    }
    
    /// 配置位置
    internal func configLocation() {
        
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backgroundView.leftAnchor.constraint(equalTo: leftAnchor),
            backgroundView.rightAnchor.constraint(equalTo: rightAnchor),
            backgroundView.topAnchor.constraint(equalTo: topAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    /// 视图添加的时候
    public override func didMoveToSuperview() {
        super.didMoveToSuperview()
        if let temSuperView = self.superview {
            translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                leftAnchor.constraint(equalTo: temSuperView.leftAnchor),
                rightAnchor.constraint(equalTo: temSuperView.rightAnchor),
                topAnchor.constraint(equalTo: temSuperView.topAnchor),
                bottomAnchor.constraint(equalTo: temSuperView.bottomAnchor),
            ])
            calculateLayout()
        }
    }
    
    /// 计算布局
    internal func calculateLayout() {
        
        guard let contentView = self.contentView else {
            fatalError("内容视图不能为nil")
        }
        
        /// 如果你是用frame布局的话
        if contentView.frame.size != CGSize.zero {
            contentViewHeight = contentView.frame.size.height
            contentViewWidth = contentView.frame.size.width
        } else {
            contentViewWidth = superview!.frame.width - alertViewEdging * 2
            let contentViewSize = contentView.systemLayoutSizeFitting(CGSize(width: contentViewWidth, height: 0.0), withHorizontalFittingPriority: UILayoutPriority.required, verticalFittingPriority: UILayoutPriority.fittingSizeLevel)
            contentViewHeight = contentViewSize.height
        }
        layoutAlertView()
    }
    
    /// 布局
    internal func layoutAlertView() {

        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        
        if let contentViewWidthAnchor = contentViewWidthAnchor {
            contentViewWidthAnchor.isActive = false
            contentViewWidthAnchor.constant = contentViewWidth
            contentViewWidthAnchor.isActive = true
        } else {
            contentViewWidthAnchor = contentView.widthAnchor.constraint(equalToConstant: contentViewWidth)
            contentViewWidthAnchor?.isActive = true
        }
        
        if let contentViewHeightAnchor = contentViewHeightAnchor {
            contentViewHeightAnchor.isActive = false
            contentViewHeightAnchor.constant = contentViewHeight
            contentViewHeightAnchor.isActive = true
        } else {
            contentViewHeightAnchor = contentView.heightAnchor.constraint(equalToConstant: contentViewHeight)
            contentViewHeightAnchor?.isActive = true
        }
        
        switch alertStyle {
        case let .actionSheet(directionType):
            
            switch directionType {
            case .left, .right, .bottom:
                contentView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
            case .top:
                contentView.topAnchor.constraint(equalTo: topAnchor).isActive = true
            }
        case .alert:
            contentView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: alertViewOriginY).isActive = true
        }
        setNeedsLayout()
        layoutIfNeeded()
    }
}
