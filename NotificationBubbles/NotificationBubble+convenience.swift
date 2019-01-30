//
//  NotificationBubble+convenience.swift
//  NotificationBubbles
//
//  Created by Francisco Gindre on 1/30/19.
//

import Foundation


public extension NotificationBubble {
   public static var sucessOptions: [NotificationBubble.Style] {
        return [ NotificationBubble.Style.animation(NotificationBubble.Animation.fade(duration: 0.5)) , NotificationBubble.Style.margins(UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)),
            NotificationBubble.Style.cornerRadius(8),
            NotificationBubble.Style.duration(timeInterval: 5),
            NotificationBubble.Style.backgroundColor(UIColor.green)]
    }
    
   public static var errorOptions: [NotificationBubble.Style] {
        return [ NotificationBubble.Style.animation(NotificationBubble.Animation.fade(duration: 0.5)) , NotificationBubble.Style.margins(UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)),
                 NotificationBubble.Style.cornerRadius(8),
                 NotificationBubble.Style.duration(timeInterval: 5),
                 NotificationBubble.Style.backgroundColor(UIColor.red)]
    }
    
   public static var darkOptions: [NotificationBubble.Style] {
        return [ NotificationBubble.Style.animation(NotificationBubble.Animation.fade(duration: 0.5)) , NotificationBubble.Style.margins(UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)),
                 NotificationBubble.Style.cornerRadius(8),
                 NotificationBubble.Style.duration(timeInterval: 5),
                 NotificationBubble.Style.backgroundColor(UIColor.black)]
    }
}
