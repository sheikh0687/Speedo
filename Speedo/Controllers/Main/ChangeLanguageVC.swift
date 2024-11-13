//
//  ChangeLanguageVC.swift
//  Speedo
//
//  Created by mac on 30/11/21.
//

import UIKit

class ChangeLanguageVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBarItem(LeftTitle: "", LeftImage: "menu", CenterTitle: R.string.localizable.changeLanguage(), CenterImage: "", RightTitle: "", RightImage: "", BackgroundColor: k.themeColor, BackgroundImage: "", TextColor: "#FFFFFF", TintColor: "#FFFFFF", Menu: "")
    }
    
    override func leftClick() {
        toggleLeft()
    }
    
    @IBAction func btnEnglish(_ sender: UIButton) {
        k.userDefault.set(emLang.english.rawValue, forKey: k.session.language)
        L102Language.setAppleLAnguageTo(lang: "en")
        Switcher.updateRootVC()
    }
    
    @IBAction func btnArabic(_ sender: UIButton) {
        k.userDefault.set(emLang.danish.rawValue, forKey: k.session.language)
        L102Language.setAppleLAnguageTo(lang: "da")
        Switcher.updateRootVC()
    }
}
