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
    @IBOutlet weak var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    @IBAction func show(_ sender: Any) {
        var options: [NotificationBubble.Style]? = nil
        switch segment.selectedSegmentIndex {
        case 0:
        options = NotificationBubble.sucessOptions
        case 1:
        options = NotificationBubble.errorOptions
        default:
        options = NotificationBubble.darkOptions
        }
    
        NotificationBubble.display(in: self.view, options: options, attributedText: NSAttributedString(string: self.textField.text ?? ""), handleTap: {
        self.present(UIAlertController.init(title: "", message: "bubble tapped", preferredStyle: UIAlertControllerStyle.alert), animated: true, completion: nil)
    
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

