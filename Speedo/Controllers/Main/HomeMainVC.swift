//
//  HomeMainVC.swift
//  Speedo
//
//  Created by mac on 18/04/21.
//

import UIKit
import SlideMenuControllerSwift

class HomeMainVC: UITabBarController {
    
    var menuContainer: SlideMenuController!
    
    var indexSelect = 4
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
    }
}

extension HomeMainVC: UITabBarControllerDelegate {
    
    // UITabBarDelegate
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        print("Selected item")
//        if self.selectedIndex != 0 {
//            Utility.showAlertMessage(withTitle: k.appName, message: "Please login to continue", delegate: nil, parentViewController: self)
//        }
    }
    
    // UITabBarControllerDelegate
    func tabBarController(tabBarController: UITabBarController, didSelectViewController viewController: UIViewController) {
        print("Selected view controller")
//        if self.selectedIndex != 0 {
//            Utility.showAlertMessage(withTitle: k.appName, message: "Please login to continue", delegate: nil, parentViewController: self)
//        }
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        print("shouldSelect view controller")
        if Utility.isUserLogin() {
            print("user logged in")
        } else {
            let selectedIndex = tabBarController.viewControllers?.firstIndex(of: viewController)!
            if selectedIndex != 0 {
                Utility.showAlertRegistration(parentViewController: self) { (bool) in
                    if bool {
                        Utility.logoutt()
                    }
                }
                return false
            }
            
        }
        return true
    }
}
