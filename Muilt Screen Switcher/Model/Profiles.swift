//
//  Profiles.swift
//  Muilt Screen Switcher
//
//  Created by CYC on 2017/4/24.
//  Copyright © 2017年 West2Studio. All rights reserved.
//

import Foundation

class Profile:NSObject,NSCoding{
    let displays:[DisplayModel]
    
    var note:String
    
    init(_ displays:[DisplayModel]) {
        self.displays = displays
        self.note = "New Profile"
    }
    
    var main:DisplayModel{
        get{
            return self.displays.filter{$0.position_x == 0 && $0.position_y == 0}.first!
        }
    }
    
    func isValid()->Bool{
        return note != ""
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.displays = aDecoder.decodeObject(forKey: "displays") as! [DisplayModel]
        self.note = aDecoder.decodeObject(forKey: "note") as? String ?? "nil"

    }
    func encode(with aCoder: NSCoder){
        aCoder.encode(displays, forKey: "displays")
        aCoder.encode(note, forKey: "note")
    }
}
