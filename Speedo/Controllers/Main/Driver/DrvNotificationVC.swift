//
//  DrvNotificationVC.swift
//  Speedo
//
//  Created by mac on 21/04/21.
//

import UIKit

class DrvNotificationVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBarItem(LeftTitle: "", LeftImage: "menu", CenterTitle: R.string.localizable.notifications(), CenterImage: "", RightTitle: "", RightImage: "", BackgroundColor: k.themeColor, BackgroundImage: "", TextColor: "#FFFFFF", TintColor: "#FFFFFF", Menu: "")
    }
    
    override func leftClick() {
        toggleLeft()
    }
}
