//
//  File.swift
//  NotificationBubbles
//
//  Created by Francisco Gindre on 1/29/19.
//

import Foundation
import UIKit

public typealias NotificationBubbleOptions = [String: Any]
public class NotificationBubble {
    public enum Style {
        
        public struct Key {
            static let backgroundColor = "backgroundColor"
            static let cornerRadius = "cornerRadius"
            static let margins = "margins"
            static let duration = "duration"
            static let animation = "animation"
        }
        case backgroundColor(_ color: UIColor)
        case cornerRadius(_ radius: CGFloat)
        case margins(_ inset: UIEdgeInsets)
        case duration(timeInterval: TimeInterval)
        case animation(_ options: NotificationBubble.Animation)
        var value: Any {
            switch self {
            case .backgroundColor(let color):
                return color
            case .cornerRadius(let radius):
                return radius
            case .margins(let margin):
                return margin
            case .duration(let duration):
                return duration
            case .animation(let animation):
                return animation
            }
        }
        var key: String {
            switch self {
            case .backgroundColor(_):
                return Key.backgroundColor
            case .cornerRadius(_):
                return Key.cornerRadius
            case .margins(_):
                return Key.margins
            case .duration(_):
                return Key.margins
            case .animation(_):
                return Key.animation
            }
        }
        
    }
    
    private static var defaultDuration: TimeInterval = 4
    private static var defaultMargins = UIEdgeInsets (top: 20, left: 0, bottom: 0, right: 0)
    private static var defaultAnimation = Animation.fade(duration: 0.4)
    private static var defaultBackgroundColor = UIColor.black
    private static var defaultCornerRadius = CGFloat(8)
    
    
    public enum Animation {
        case none
        case slide(duration: TimeInterval)
        case fade(duration: TimeInterval)
        
        static var key: String {
            return "animation"
        }
    }
    
    @discardableResult public static func display(in view: UIView, options: [NotificationBubble.Style]?, attributedText: NSAttributedString, handleTap: ()->()) -> DisplayedBubbleView {
        
        let size = attributedText.size()
        
        let bubble = NotificationBubbleView(frame: CGRect(origin: CGPoint.zero, size:size))
        
        let userOptions = options?.toStyleDictionary()
        
        let backgroundColor = userOptions?[NotificationBubble.Style.Key.backgroundColor] as? UIColor ?? defaultBackgroundColor
        let cornerRadius = userOptions?[NotificationBubble.Style.Key.cornerRadius] as? CGFloat ?? defaultCornerRadius
        
        let animationOptions = userOptions?[NotificationBubble.Style.Key.animation] as? NotificationBubble.Animation ?? defaultAnimation
        let marginOption = userOptions?[NotificationBubble.Style.Key.margins] as? UIEdgeInsets ?? defaultMargins
        let bubbleDuration = userOptions?[NotificationBubble.Style.Key.duration] as? TimeInterval ?? defaultDuration
        
        bubble.containerView.backgroundColor = backgroundColor
        bubble.containerView.layer.cornerRadius = cornerRadius
        bubble.containerView.layer.masksToBounds = true
        bubble.label.attributedText = attributedText
        bubble.layoutIfNeeded()
        switch animationOptions {
        case .none:
            view.addSubview(bubble)
            bubble.alignToSuperviewHorizontalCenter()
            bubble.constraintTopToSuperviewTop(constant: marginOption.top)
            if size.width > view.bounds.size.width {
                bubble.constraintTo(width: view.bounds.size.width - 32)
            }
            view.bringSubviewToFront(bubble)
        case .fade(let duration):
            bubble.alpha = 0
            view.addSubview(bubble)
            bubble.alignToSuperviewHorizontalCenter()
            bubble.constraintTopToSuperviewTop(constant: marginOption.top)
            if size.width > view.bounds.size.width {
                bubble.constraintTo(width: view.bounds.size.width - 32)
            }
            UIView.animate(withDuration: duration) {
                bubble.alpha = 1.0
            }
        case .slide(let duration):
            bubble.frame = CGRect(x: view.bounds.midX - (bubble.frame.midX), y: 0, width: bubble.frame.width, height: bubble.frame.height)
            view.addSubview(bubble)
            bubble.alignToSuperviewHorizontalCenter()
            if size.width > view.bounds.size.width {
                bubble.constraintTo(width: view.bounds.size.width - 32)
            }
            UIView.animate(withDuration: duration, delay: 0, options: UIView.AnimationOptions.curveEaseIn, animations: {
                bubble.frame.origin.y += 120
            }, completion: { _ in
                
                print("frame: \(bubble)")
            })
            
        }
        
        let finalOptions: NotificationBubbleOptions = [NotificationBubble.Style.Key.backgroundColor : backgroundColor,
                                                       NotificationBubble.Style.Key.cornerRadius : cornerRadius,
                                                       NotificationBubble.Style.Key.animation :animationOptions,
                                                       NotificationBubble.Style.Key.margins : marginOption,
                                                       NotificationBubble.Style.Key.duration :
                                                        bubbleDuration]
        
        let displayedBubble = DisplayedBubbleView(displayingView: view, bubbleView: bubble, options: finalOptions)

        DispatchQueue.main.asyncAfter(deadline: .now() + bubbleDuration) {
            displayedBubble.hide()
        }
        
        return displayedBubble
    }
    
    static private func hide(bubble: DisplayedBubbleView) {
        hide(in: bubble.displayingView, bubbleView: bubble.bubbleView, options: bubble.options)
    }
    
    static func hide(in view: UIView, bubbleView: NotificationBubbleView, options: NotificationBubbleOptions ) {
        
        let animationOption = options[NotificationBubble.Style.Key.animation] as? Animation ?? defaultAnimation
        
        switch animationOption {
        case .fade(let duration):
            UIView.animate(withDuration: duration, animations: {
                bubbleView.alpha = 0
            }) { _ in
                bubbleView.removeFromSuperview()
            }
        case .none:
            bubbleView.removeFromSuperview()
            break
        case .slide(let duration):
            UIView.animate(withDuration: duration, delay: 0, options: UIView.AnimationOptions.curveEaseOut, animations: {
                bubbleView.frame.origin.y -= 120
            }) { _ in
                bubbleView.removeFromSuperview()
            }
        }
    }
    
}

public struct DisplayedBubbleView {
    unowned private(set) var displayingView: UIView
    unowned fileprivate var bubbleView: NotificationBubbleView
    fileprivate var options: NotificationBubbleOptions
    
    init(displayingView: UIView, bubbleView: NotificationBubbleView, options: NotificationBubbleOptions) {
        self.displayingView = displayingView
        self.bubbleView = bubbleView
        self.options = options
    }
    
    public func hide() {
        NotificationBubble.hide(in: displayingView, bubbleView: bubbleView, options: options)
    }
    
}

class NotificationBubbleView: UIView {
    
    var label: UILabel! = UILabel(frame: CGRect.zero)
    var tapBlock: (()->())?
    var containerView = UIView(frame: CGRect.zero)
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        setup()
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds,
                                             cornerRadius: self.layer.cornerRadius).cgPath
    }
    private func setup() {
        self.containerView.translatesAutoresizingMaskIntoConstraints = false
        self.containerView.layoutMargins = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        self.addSubview(containerView)
        
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "H:|-(left)-[containerView]-(right)-|",
                                                                   options: NSLayoutConstraint.FormatOptions(),
                                                                   metrics: ["left": 0, "right": 0],
                                                                   views: ["containerView": containerView]))
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "V:|-(up)-[containerView]-(down)-|",
                                                                   options: NSLayoutConstraint.FormatOptions(),
                                                                   metrics: ["up": 0, "down": 0],
                                                                   views: ["containerView": containerView]))
        
        self.backgroundColor = UIColor.clear
        self.layer.backgroundColor = UIColor.clear.cgColor
        
        self.layer.shadowOffset = CGSize(width: 4, height: 4)
        self.layer.shadowOpacity = 0.2
        self.layer.shadowColor = UIColor.lightGray.cgColor
        
        
        label.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(label)
        
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "H:|-(left)-[label]-(right)-|",
                                                                   options: NSLayoutConstraint.FormatOptions(),
                                                                   metrics: ["left": 8, "right": 8],
                                                                   views: ["label": label]))
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "V:|-(up)-[label]-(down)-|",
                                                                   options: NSLayoutConstraint.FormatOptions(),
                                                                   metrics: ["up": 8, "down": 8],
                                                                   views: ["label": label]))
        label.numberOfLines = 0
        label.setContentCompressionResistancePriority(UILayoutPriority(750), for: .horizontal)
        label.setContentCompressionResistancePriority(UILayoutPriority(999), for: .vertical)
        label.setContentHuggingPriority(UILayoutPriority(rawValue: 999), for: .horizontal)
        label.setContentHuggingPriority(UILayoutPriority(rawValue: 750), for: .vertical)
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        
        self.containerView.setContentHuggingPriority(UILayoutPriority(rawValue: 750), for: .horizontal)
        self.containerView.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 999), for: .horizontal)
        self.setContentHuggingPriority(UILayoutPriority(rawValue: 999), for: .horizontal)
        self.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 750), for: .horizontal)
        
        self.addGestureRecognizer(UIGestureRecognizer(target: self, action: #selector(handleTap(_:))))
        
    }
    
    @objc func handleTap(_ gesture: UIGestureRecognizer) {
        tapBlock?()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


extension Array where Element == NotificationBubble.Style {
    
    func toStyleDictionary() -> NotificationBubbleOptions{
        var d = NotificationBubbleOptions()
        self.forEach{ d[$0.key] = $0.value }
        return d
    }
}
