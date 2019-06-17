//
//  NotificationBubble+convenience.swift
//  NotificationBubbles
//
//  Created by Francisco Gindre on 1/30/19.
//

import Foundation
import UIKit
extension UIView {
    
    func alignToSuperviewHorizontalCenter() {
        NSLayoutConstraint.activate([NSLayoutConstraint(item: self,
                                                        attribute: NSLayoutConstraint.Attribute.centerXWithinMargins,
                                                        relatedBy: NSLayoutConstraint.Relation.equal,
                                                        toItem: self.superview,
                                                        attribute: NSLayoutConstraint.Attribute.centerXWithinMargins,
                                                        multiplier: 1,
                                                        constant: 0)])
    }
    
    func constraintTo(width: CGFloat) {
        NSLayoutConstraint.activate([NSLayoutConstraint(item: self, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: width)])
    }
    
    func constraintTopToSuperviewTop(constant: CGFloat) {
        NSLayoutConstraint.activate([NSLayoutConstraint(item: self, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal , toItem: self.superview, attribute: .top, multiplier: 1, constant: constant)])
    }
}
