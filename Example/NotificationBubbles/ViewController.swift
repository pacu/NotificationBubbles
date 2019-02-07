//
//  ViewController.swift
//  NotificationBubbles
//
//  Created by Francisco Gindre on 01/29/2019.
//  Copyright (c) 2019 Francisco Gindre. All rights reserved.
//

import UIKit
import NotificationBubbles
class ViewController: UIViewController {
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var segment: UISegmentedControl!
    @IBOutlet weak var bubbleDurationSegment: UISegmentedControl!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var animationSegment: UISegmentedControl!
    var displayedBubble: DisplayedBubbleView?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    @IBAction func show(_ sender: Any) {
        var options: [NotificationBubble.Style]? = nil
        var animation: NotificationBubble.Animation = NotificationBubble.Animation.none
        
        switch animationSegment.selectedSegmentIndex {
            case 0:
                animation = .none
            case 1:
                animation = .fade(duration: 0.5)
            default:
                animation = .slide(duration: 0.5)
        }
        
        var duration: TimeInterval = 5
        
        switch bubbleDurationSegment.selectedSegmentIndex {
        case 0:
            duration = -1.0
        case 1:
            duration = 2.0
        default:
            duration = 5
        }
        
        switch segment.selectedSegmentIndex {
            case 0:
                options = NotificationBubble.sucessOptions(animation: animation, duration: duration)
            case 1:
                options = NotificationBubble.errorOptions(animation: animation, duration: duration)
            default:
                options = NotificationBubble.neutralOptions(animation: animation)
        }
    
        displayedBubble = NotificationBubble.display(in: self.view, options: options, attributedText: NSAttributedString(string: self.textField.text ?? ""), handleTap: {
            let alert = UIAlertController.init(title: "", message: "bubble tapped", preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction.init(title: "close", style: UIAlertAction.Style.cancel, handler: { _ in
                alert.dismiss(animated: true, completion: nil)
                
            }))
            self.present(alert, animated: true, completion: nil)
            self.displayedBubble?.hide()
            
        })
        
        
    
    }  
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
        
        
    }
}

public extension NotificationBubble {
    static func sucessOptions(animation: NotificationBubble.Animation, duration: TimeInterval = 5) -> [NotificationBubble.Style] {
        return [ NotificationBubble.Style.animation(animation),
                 NotificationBubble.Style.margins(UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)),
                 NotificationBubble.Style.cornerRadius(8),
                 NotificationBubble.Style.duration(timeInterval: duration),
                 NotificationBubble.Style.backgroundColor(UIColor.green)]
    }
    
    static func errorOptions(animation: NotificationBubble.Animation, duration: TimeInterval = 5) -> [NotificationBubble.Style] {
        return [ NotificationBubble.Style.animation(animation),
                 NotificationBubble.Style.margins(UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)),
                 NotificationBubble.Style.cornerRadius(8),
                 NotificationBubble.Style.duration(timeInterval: duration),
                 NotificationBubble.Style.backgroundColor(UIColor.red)]
    }
    
    static func neutralOptions(animation: NotificationBubble.Animation, duration: TimeInterval = 5) -> [NotificationBubble.Style] {
        return [ NotificationBubble.Style.animation(animation),
                 NotificationBubble.Style.margins(UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)),
                 NotificationBubble.Style.cornerRadius(8),
                 NotificationBubble.Style.duration(timeInterval: duration),
                 NotificationBubble.Style.backgroundColor(UIColor.lightGray)]
    }
}
