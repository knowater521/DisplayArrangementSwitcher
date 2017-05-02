//
//  DisplayModel.swift
//  Muilt Screen Switcher
//
//  Created by CYC on 2017/4/24.
//  Copyright © 2017年 West2Studio. All rights reserved.
//

import Foundation
import AppKit

class DisplayModel:NSObject,NSCoding{
    
    let screen_id:CGDirectDisplayID
    let screen_width:Int32
    let screen_height:Int32
    
    let position_x:Int32
    let position_y:Int32
    
    init(_ screen:NSScreen){
        let screen_info = screen.deviceDescription
        
        screen_id = screen_info["NSScreenNumber"] as! CGDirectDisplayID
        let screen_size = screen_info["NSDeviceSize"] as! NSSize
        screen_width = Int32(screen_size.width)
        screen_height = Int32(screen_size.height)
        
        let position = screen.frame
        position_x = Int32(position.origin.x)
        position_y = Int32(position.origin.y)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.screen_id = aDecoder.decodeObject(forKey: "screen_id") as! CGDirectDisplayID
        self.screen_width = aDecoder.decodeInt32(forKey: "screen_width")
        self.screen_height = aDecoder.decodeInt32(forKey: "screen_height")
        self.position_x = aDecoder.decodeInt32(forKey: "position_x")
        self.position_y = aDecoder.decodeInt32(forKey: "position_y")
    }
    func encode(with aCoder: NSCoder){
        aCoder.encode(screen_id, forKey: "screen_id")
        aCoder.encode(screen_width, forKey: "screen_width")
        aCoder.encode(screen_height, forKey: "screen_height")
        aCoder.encode(position_x, forKey: "position_x")
        aCoder.encode(position_y, forKey: "position_y")
    }
}
