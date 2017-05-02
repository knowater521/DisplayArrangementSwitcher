//
//  ScreenHelper.swift
//  Muilt Screen Switcher
//
//  Created by CYC on 2017/4/24.
//  Copyright © 2017年 West2Studio. All rights reserved.
//

import Foundation
import AppKit

class ScreenHelper{
    private init(){}
    static let shared = ScreenHelper()
    
    func getProfile() -> Profile{
        let screens = NSScreen.screens() ?? []
        let model_array = screens.map{DisplayModel($0)}
        return Profile(model_array)
    }
    
    func setScreens(_ profile:Profile){
        let config = UnsafeMutablePointer<CGDisplayConfigRef?>.allocate(capacity:1)
        
        let queue = DispatchQueue.global(qos:.userInitiated)
        
        queue.async {
            CGBeginDisplayConfiguration(config)
            let main_height = profile.main.screen_height
            for display in profile.displays{
                
                let error:CGError
                
                if display.position_x == 0 && display.position_y == 0{
                    error = CGConfigureDisplayOrigin(config.pointee, display.screen_id, 0, 0)
                   
                }else{
                    error = CGConfigureDisplayOrigin(config.pointee, display.screen_id, display.position_x, -display.position_y - display.screen_height + main_height)
                }
                
                if error != .success{
                    CGCancelDisplayConfiguration(config.pointee)
                    UserNotificationHelper.shared.post(title: "切换失败", subtitle: "显示器配置错误")
                    return
                }
                
            }
            
            
            let error = CGCompleteDisplayConfiguration(config.pointee, .permanently)
            if error != .success{
                CGCancelDisplayConfiguration(config.pointee)
                UserNotificationHelper.shared.post(title: "切换失败", subtitle: "配置应用失败")
                return
            }
            UserNotificationHelper.shared.post(title: "切换成功", subtitle: "")

        }
    }
}
