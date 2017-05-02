//
//  NotificationHelper.swift
//  Muilt Screen Switcher
//
//  Created by CYC on 2017/4/25.
//  Copyright © 2017年 West2Studio. All rights reserved.
//

import Foundation

class UserNotificationHelper:NSObject,NSUserNotificationCenterDelegate{
    private override init(){
        super.init()
        nc.delegate = self
    }
    static let shared = UserNotificationHelper()
    
    fileprivate let nc = NSUserNotificationCenter.default
    
    func post(title:String,subtitle:String){
        let notic = NSUserNotification()
        notic.title = title
        notic.subtitle = subtitle
        self.nc.deliver(notic)
    }
    
    func userNotificationCenter(_ center: NSUserNotificationCenter, shouldPresent notification: NSUserNotification) -> Bool{
        return true
    }
    
}
