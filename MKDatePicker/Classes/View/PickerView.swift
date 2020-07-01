//
//  PickerView.swift
//  XBDatePicker
//
//  Created by xiaobin liu on 2020/3/10.
//  Copyright © 2019 XBPickerView. All rights reserved.
//

import UIKit

/// MARK - PickerView
public class PickerView: UIPickerView {
    
    /// 单位标签
    private lazy var unitLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    /// 单边标签左边距离
    public var unitLabelLeftConstraint: NSLayoutConstraint?
    
    /// 选中属性
    public var selectedAttributes: [NSAttributedString.Key : Any]?
    
    /// 单位富文本
    public var unitAttributedText: NSAttributedString? {
        didSet {
            self.unitLabel.backgroundColor = UIColor.clear
            self.unitLabel.attributedText = unitAttributedText
        }
    }
    
    /// 灰色的线
    public var lineColor: UIColor = UIColor(red: 183.0/255.0, green: 183.0/255.0, blue: 183.0/255.0, alpha: 1.0)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureSubviews()
    }
    
    /// 配置视图
    private func configureSubviews() {
        backgroundColor = UIColor.white
        addSubview(unitLabel)
        unitLabelLeftConstraint = unitLabel.leftAnchor.constraint(equalTo: centerXAnchor, constant: 0)
        unitLabelLeftConstraint?.isActive = true
        unitLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 1.5).isActive = true
    }
    
    public override func numberOfRows(inComponent component: Int) -> Int {
        return Int.max
    }
    
   /// UITableViewDataSource
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableViewCell = super.tableView(tableView, cellForRowAt: indexPath)
        if tableView.superview === tableView.superview?.superview?.subviews.last {
            
            var label = tableViewCell.subviews.last?.subviews.first as? UILabel
            if #available(iOS 14.0, *) {
                label = label == nil ? tableViewCell.subviews.first?.subviews.first as? UILabel : label
            }
            
            if let temView = label,
               let temSelectedAttributes = selectedAttributes {
                temView.attributedText = NSAttributedString(string: temView.text ?? "", attributes: temSelectedAttributes)
            }
        }
        return tableViewCell
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        for item in self.subviews {

            if #available(iOS 14.0, *) {
                if item.frame.size.height == 42 {
                    item.backgroundColor = UIColor.clear
                    let topView = UIView()
                    topView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 1/UIScreen.main.scale)
                    topView.backgroundColor = lineColor
                    item.addSubview(topView)

                    let bottomView = UIView()
                    bottomView.frame = CGRect(x: 0, y: item.frame.size.height - 1/UIScreen.main.scale, width: UIScreen.main.bounds.width, height: 1/UIScreen.main.scale)
                    bottomView.backgroundColor = lineColor
                    item.addSubview(bottomView)
                }
            } else {
                if item.frame.size.height < 1 {
                    item.backgroundColor = lineColor
                }
            }
        }
    }
}

