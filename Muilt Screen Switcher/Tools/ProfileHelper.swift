//
//  ProfileHelper.swift
//  Muilt Screen Switcher
//
//  Created by CYC on 2017/4/24.
//  Copyright © 2017年 West2Studio. All rights reserved.
//

import Foundation

class ProfileHelper{
    private init(){}
    static let shared = ProfileHelper()
    
    let PROFILE_KEY = "Profiles"
    
    
    let data = UserDefaults.standard
    
    var profiles:[Profile]{
        get{
            if let x = data.object(forKey: PROFILE_KEY) as? NSArray {
                return x.map{
                    NSKeyedUnarchiver.unarchiveObject(with: $0 as! Data ) as! Profile
                }
            }else{
                return []
            }
        }
        set{
            let array = newValue.map{
                NSKeyedArchiver.archivedData(withRootObject: $0)
            }
            
            data.set(array, forKey: PROFILE_KEY)
        }
    }
    
    func addProfile(_ profile:Profile){
        self.profiles.append(profile)
        print(profiles)
    }
    
    
    
}
