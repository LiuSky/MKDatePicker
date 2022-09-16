# MKDatePicker

[![build](https://github.com/Pircate/CleanJSON/workflows/build/badge.svg)](https://github.com/Pircate/CleanJSON/actions?query=workflow%3ASwift)
[![Version](https://img.shields.io/cocoapods/v/MKDatePicker.svg?style=flat)](https://cocoapods.org/pods/MKDatePicker)
[![License](https://img.shields.io/cocoapods/l/MKDatePicker.svg?style=flat)](https://cocoapods.org/pods/MKDatePicker)
[![Platform](https://img.shields.io/cocoapods/p/MKDatePicker.svg?style=flat)](https://cocoapods.org/pods/MKDatePicker)


## Requirements:
- **iOS** 9.0+
- Xcode 10.0+
- Swift 5.0+

## Demo Figure
<p align="center">
<img src="https://github.com/LiuSky/MKDatePicker/blob/master/1.png?raw=true" title="演示图1">
<img src="https://github.com/LiuSky/MKDatePicker/blob/master/2.png?raw=true" title="演示图2">
<img src="https://github.com/LiuSky/MKDatePicker/blob/master/3.png?raw=true" title="演示图3">
</p>


## Installation Cocoapods
<pre><code class="ruby language-ruby">pod 'MKDatePicker', '~> 1.0.0'</code></pre>

## Use

```swift
        let contentView = PickerViewController()
        contentView.type = type
        contentView.headerView.title = NSAttributedString(string: headerTitle, attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 16),
                                                                                 NSAttributedString.Key.foregroundColor: UIColor.black])
        contentView.selectDate = selectDate
        contentView.maximumDate = maximumDate
        contentView.minimumDate = minimumDate
        contentView.selectedAttributes = selectedAttributes
        contentView.confirmCallBack = { (_, result) in
            debugPrint(result.toString(format: dateFormatType))
        }
        contentView.cancelCallBack = { _ in
            debugPrint("取消")
        }
        contentView.show()
```

## License

MKDatePicker is available under the MIT license. See the LICENSE file for more info.

