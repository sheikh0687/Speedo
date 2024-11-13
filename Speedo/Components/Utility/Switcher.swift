//
//  Switcher.swift
//  WeCare
//
//  Created by mac on 01/10/18.
//  Copyright © 2018 Technorizen. All rights reserved.
//

import UIKit
import SlideMenuControllerSwift

class Switcher {
    
    static func updateRootVC() {
        
        let status = k.userDefault.bool(forKey: k.session.status)
        let type = k.userDefault.string(forKey: k.session.userType)
        
        if status {
            switch type {
            case "USER":
                let mainViewController = R.storyboard.main().instantiateViewController(withIdentifier: "HomeMainVC") as! HomeMainVC
                let leftViewController = R.storyboard.main().instantiateViewController(withIdentifier: "LeftSideMenuVC") as! LeftSideMenuVC
                let rootVC = SlideMenuController(mainViewController: mainViewController, leftMenuViewController: leftViewController)
                
                kAppDelegate.window?.rootViewController = rootVC
                kAppDelegate.window?.makeKeyAndVisible()
            case "RESTAURANT":
                let mainViewController = R.storyboard.main().instantiateViewController(withIdentifier: "ResHomeMainVC") as! ResHomeMainVC
                let leftViewController = R.storyboard.main().instantiateViewController(withIdentifier: "ResLeftSideMenu") as! ResLeftSideMenu
                let rootVC = SlideMenuController(mainViewController: mainViewController, leftMenuViewController: leftViewController)
                kAppDelegate.window?.rootViewController = rootVC
                kAppDelegate.window?.makeKeyAndVisible()
            case "DRIVER":
                let mainViewController = R.storyboard.main().instantiateViewController(withIdentifier: "DrvHomeMainVC") as! DrvHomeMainVC
                let leftViewController = R.storyboard.main().instantiateViewController(withIdentifier: "DrvLeftSideMenu") as! DrvLeftSideMenu
                let rootVC = SlideMenuController(mainViewController: mainViewController, leftMenuViewController: leftViewController)
                
                kAppDelegate.window?.rootViewController = rootVC
                kAppDelegate.window?.makeKeyAndVisible()
            default:
                print("No User Type Find")
            }            
        } else {
            let rootVC = R.storyboard.main().instantiateViewController(withIdentifier: "LandingVC") as! LandingVC
            let nav = UINavigationController(rootViewController: rootVC)
            nav.isNavigationBarHidden = false
            kAppDelegate.window!.rootViewController = nav
            kAppDelegate.window?.makeKeyAndVisible()
        }
    }
    
    static func logoutFromGuest() {
        let rootVC = R.storyboard.main().instantiateViewController(withIdentifier: "PrimaryMainVC") as! PrimaryMainVC
        rootVC.form = "Login"
        rootVC.type = "USER"
        let nav = UINavigationController(rootViewController: rootVC)
        nav.isNavigationBarHidden = false
        kAppDelegate.window!.rootViewController = nav
        kAppDelegate.window?.makeKeyAndVisible()
    }
    
    static func logToGuest() {
        let mainViewController = R.storyboard.main().instantiateViewController(withIdentifier: "HomeMainVC") as! HomeMainVC
        let leftViewController = R.storyboard.main().instantiateViewController(withIdentifier: "LeftSideMenuVC") as! LeftSideMenuVC
        let rootVC = SlideMenuController(mainViewController: mainViewController, leftMenuViewController: leftViewController)
        
        kAppDelegate.window?.rootViewController = rootVC
        kAppDelegate.window?.makeKeyAndVisible()
    }
}



