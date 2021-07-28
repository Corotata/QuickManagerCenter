//
//  SessionManager.swift
//  QuickManagerCenter_Example
//
//  Created by Corotata on 2021/7/28.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation
import QuickManagerCenter

class SessionManager: Manager {
    override func onManagerInit() {
        self.isKeepLiveAlways = false
        print("SessionManager init")
    }
    
    override func onManagerDidEnterBackground() {
        print("SessionManager onManagerDidEnterBackground")
    }
    
    override func onManagerWillEnterForeground() {
        print("SessionManager onManagerWillEnterForeground")
    }
    
    override func onManagerDidLogin() {
        print("SessionManager onManagerDidLogin")
    }
    
    override func onManagerDidLogout()  {
        print("SessionManager onManagerDidLogout")
    }
    
    override func onManagerMemoryWarning()  {
        print("SessionManager onManagerMemoryWarning")
    }
    
    deinit {
        print("SessionManager deinit")
    }
}
