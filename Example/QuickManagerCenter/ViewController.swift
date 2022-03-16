//
//  ViewController.swift
//  QuickManagerCenter
//
//  Created by corotata on 07/28/2021.
//  Copyright (c) 2021 corotata. All rights reserved.
//

import UIKit
import QuickManagerCenter

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        _ = GetManager(type: MessageManager.self,tagId: "123123",params: ["key":"3333"])
        _ = GetManager(type: SessionManager.self)
        
        let array = ManagerCenter.default.dict
        
        print(array)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func didEnterBackground(_ sender: UIButton) {
        ManagerCenter.default.applicationDidEnterBackground()
    }
    
    @IBAction func willEnterForeground(_ sender: UIButton) {
        ManagerCenter.default.applicationWillEnterForeground()
    }
    
    @IBAction func didLogin(_ sender: UIButton) {
        ManagerCenter.default.onUserDidLogin()
    }
    
    
    @IBAction func didLogout(_ sender: UIButton) {
        ManagerCenter.default.onUserDidLogout()
    }
    
    
    @IBAction func memoryWarning(_ sender: UIButton) {
        ManagerCenter.default.applicationDidReceiveMemoryWarning()
    }
    

    @IBAction func reset(_ sender: UIButton) {
        _ = GetManager(type: MessageManager.self)
        _ = GetManager(type: SessionManager.self)
    }
}
