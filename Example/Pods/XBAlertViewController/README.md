# XBAlertViewController

[![CI Status](https://img.shields.io/travis/LiuSky/XBAlertViewController.svg?style=flat)](https://travis-ci.org/LiuSky/XBAlertViewController)
[![Version](https://img.shields.io/cocoapods/v/XBAlertViewController.svg?style=flat)](https://cocoapods.org/pods/XBAlertViewController)
[![License](https://img.shields.io/cocoapods/l/XBAlertViewController.svg?style=flat)](https://cocoapods.org/pods/XBAlertViewController)
[![Platform](https://img.shields.io/cocoapods/p/XBAlertViewController.svg?style=flat)](https://cocoapods.org/pods/XBAlertViewController)

## Requirements:
- **iOS** 9.0+
- Xcode 10.0+
- Swift 5.0+


## Installation Cocoapods
<pre><code class="ruby language-ruby">pod 'XBAlertViewController', '~> 1.0.0'</code></pre>

## Usage

```swift
         let autolatoutView = XBAutolatoutView()
        XBShowAlertView.showAlertView(alertStyle: type,
                                      showInView: self.view,
                                      contentView: autolatoutView,
                                      backgoundTapDismissEnable: true,
                                      isShowMask: true,
                                      alertViewEdging: 20,
                                      alertViewOriginY: 0, delegate: self)
```

## License
XBAlertViewController is released under an MIT license. See [LICENSE](LICENSE) for more information.

