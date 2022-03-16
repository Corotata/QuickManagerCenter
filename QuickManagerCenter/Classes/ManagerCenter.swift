
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
    
    //用于做关联标记的，通常可以放用户ID，用于做用户特定业务的处理
    var tagId: String?
    
    var params: [String: AnyHashable]?
    
    
//    required public init(){}
    
    required public init(tagId: String? = nil,params: [String: AnyHashable]? = nil) {
        self.tagId = tagId
        self.params = params
    }
    
}


public func GetManager<T: Manager>(type: T.Type,tagId: String? = nil, params: [String: AnyHashable]? = nil)  -> T  {
    ManagerCenter.default.getManager(type: type,tagId: tagId,params: params)
}


open class ManagerCenter {
    public static let `default` = ManagerCenter()
    
    let lock = NSRecursiveLock()
    
    public var dict = [String: Manager]()
    private init() {}
    
    open func getManager<T: Manager>(type: T.Type,tagId: String? = nil, params: [String: AnyHashable]? = nil) -> T  {
        
        lock.lock()
        var key = "\(type)"
        
        if let tagId = tagId {
            key = "\(key):\(tagId)"
        }
        
        
        var manager = dict[key]
        
        if manager != nil {
            lock.unlock()
            return manager as! T
        }
        
        manager = type.init(tagId: tagId,params: params)
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







