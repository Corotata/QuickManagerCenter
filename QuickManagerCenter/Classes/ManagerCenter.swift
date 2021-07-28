
//
//  ManagerCenter.swift
//  QuickManagerCenter
//
//  Created by Corotata on 2021/7/28.
//  Copyright © 2021 Corotata. All rights reserved.
//


open class Manager {
    open var isKeepLiveAlways = false
    
    open func onManagerInit() {}
    
    open func onManagerDidEnterBackground() {}
    
    open func onManagerWillEnterForeground() {}
    
    open func onManagerDidLogin() {}
    
    open func onManagerDidLogout()  {}
    
    open func onManagerMemoryWarning()  {}
    
    required public init(){}
}


public func GetManager<T: Manager>(type: T.Type)  -> T  {
    ManagerCenter.default.getManager(type: type)
}


open class ManagerCenter {
    public static let `default` = ManagerCenter()
    
    let lock = NSRecursiveLock()
    
    var dict = [String: Manager]()
    private init() {}
    
    open func getManager<T: Manager>(type: T.Type) -> T  {
        
        lock.lock()
        let key = "\(type)"
        var manager = dict[key]
        
        if manager != nil {
            lock.unlock()
            return manager as! T
        }
        
        manager = type.init()
        manager?.onManagerInit()
        dict[key] = manager
        
        lock.unlock()
        return manager as! T
    }
    
    open func applicationDidEnterBackground() {
        publishAction { manager in
            manager.onManagerDidEnterBackground()
        }
    }
    
    open func applicationWillEnterForeground() {
        publishAction { manager in
            manager.onManagerWillEnterForeground()
        }
    }
    
    open func applicationDidReceiveMemoryWarning() {
        publishAction { manager in
            manager.onManagerMemoryWarning()
        }
    }
    
    open func onUserDidLogin() {
        publishAction { manager in
            manager.onManagerDidLogin()
        }
    }
    
    open func onUserDidLogout() {
        publishAction { manager in
            manager.onManagerDidLogout()
            
            if(!manager.isKeepLiveAlways) {
                dict.removeValue(forKey: "\(type(of: manager))")
            }
        }
    }
    
    open func publishAction(action: (_ manager: Manager)->()) {
        for (_,manager) in dict {
            action(manager)
        }
    }
}







