//
//  AppDelegate.swift
//  Muilt Screen Switcher
//
//  Created by CYC on 2017/4/24.
//  Copyright © 2017年 West2Studio. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    var statusItem: NSStatusItem! = NSStatusBar.system().statusItem(withLength: 25)

    @IBOutlet weak var Menu: NSMenu!
    
    @IBOutlet weak var settingMenuItem: NSMenuItem!
    @IBOutlet weak var firstSeparatorMenuItem: NSMenuItem!
    @IBOutlet weak var secondSparatorMenuItem: NSMenuItem!
    @IBOutlet weak var quitMenuItem: NSMenuItem!

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        setupMenu()
        updateMenu()
    }

    func setupMenu(){
        let img = #imageLiteral(resourceName: "logo")
        img.resizingMode = .stretch
        statusItem.image = img
        statusItem.menu = Menu
    }
    
    func updateMenu(){
        let begin_place = Menu.index(of: firstSeparatorMenuItem)
        let end_place = Menu.index(of: secondSparatorMenuItem)
        
        for _ in begin_place+1 ..< end_place{
            Menu.removeItem(at: begin_place+1)
        }
        
        var tag = 0
        for each in ProfileHelper.shared.profiles{
            let item = NSMenuItem()
            item.tag = tag
            item.title = each.note
            item.action = #selector(selectProfile)
            Menu.insertItem(item, at: begin_place + 1 + tag)
            tag += 1

        }
    }

    func selectProfile(sender: NSMenuItem){
        let index = sender.tag
        let profile = ProfileHelper.shared.profiles[index]
        ScreenHelper.shared.setScreens(profile)
    }

}

