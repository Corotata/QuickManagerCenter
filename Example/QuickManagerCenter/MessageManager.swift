//
//  MessageManager.swift
//  QuickManagerCenter_Example
//
//  Created by Corotata on 2021/7/28.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation
import QuickManagerCenter

class MessageManager: Manager {
    override func onManagerInit() {
        self.isKeepLiveAlways = true
        print("MessageManager init")
    }
    
    
    override func onManagerDidEnterBackground() {
        print("MessageManager onManagerDidEnterBackground")
    }
    
    override func onManagerWillEnterForeground() {
        print("MessageManager onManagerWillEnterForeground")
    }
    
    override func onManagerDidLogin() {
        print("MessageManager onManagerDidLogin")
    }
    
    override func onManagerDidLogout()  {
        print("MessageManager onManagerDidLogout")
    }
    
    override func onManagerMemoryWarning()  {
        print("MessageManager onManagerMemoryWarning")
    }
    
    deinit {
        print("MessageManager deinit")
    }
    
    
}
