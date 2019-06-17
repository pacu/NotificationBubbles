# NotificationBubbles [![Build Status](https://travis-ci.com/pacu/NotificationBubbles.svg?branch=master)](https://travis-ci.com/pacu/NotificationBubbles)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

NotificationBubble is a class that displays a notification based on Options defining it's style into a UIView.

Example: display a text input from a textfield, using a bubble that can handle a block when taapped. 
``` swift
  NotificationBubble.display(in: self.view, options: options, attributedText: NSAttributedString(string: self.textField.text ?? ""), handleTap: {
        self.present(UIAlertController.init(title: "", message: "bubble tapped", preferredStyle: UIAlertController.Style.alert), animated: true, completion: nil)
    
        })
```

a green bubble that shows with a 20p margin
``` swift
public extension NotificationBubble {
    public static func sucessOptions(animation: NotificationBubble.Animation) -> [NotificationBubble.Style] {
        return [ NotificationBubble.Style.animation(animation),
                 NotificationBubble.Style.margins(UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)),
                 NotificationBubble.Style.cornerRadius(8),
                 NotificationBubble.Style.duration(timeInterval: 5),
                 NotificationBubble.Style.backgroundColor(UIColor.green)]
    }
```

A red bubble 
``` swift
    public static func errorOptions(animation: NotificationBubble.Animation) -> [NotificationBubble.Style] {
        return [ NotificationBubble.Style.animation(animation),
                 NotificationBubble.Style.margins(UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)),
                 NotificationBubble.Style.cornerRadius(8),
                 NotificationBubble.Style.duration(timeInterval: 5),
                 NotificationBubble.Style.backgroundColor(UIColor.red)]
    }
```
a gray bubble
``` swift
    public static func neutralOptions(animation: NotificationBubble.Animation) -> [NotificationBubble.Style] {
        return [ NotificationBubble.Style.animation(animation),
                 NotificationBubble.Style.margins(UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)),
                 NotificationBubble.Style.cornerRadius(8),
                 NotificationBubble.Style.duration(timeInterval: 5),
                 NotificationBubble.Style.backgroundColor(UIColor.lightGray)]
    }
}
```

## Installation

NotificationBubbles is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'NotificationBubbles'
```

## Usage
See example project
## Author

Francisco Gindre, francisco.gindre@gmail.com

## License

NotificationBubbles is available under the MIT license. See the LICENSE file for more info.
