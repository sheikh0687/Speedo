//
//  TermsVC.swift
//  Speedo
//
//  Created by mac on 05/03/22.
//

import UIKit

class TermsVC: UIViewController {

    @IBOutlet weak var txtMessage: UITextView!
    
    var restCodeId = ""
    var comingFrom = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if self.comingFrom == "signup" {
            setNavigationBarItem(LeftTitle: "", LeftImage: "back", CenterTitle: R.string.localizable.termsAndCondition(), CenterImage: "", RightTitle: "", RightImage: "", BackgroundColor: k.themeColor, BackgroundImage: "", TextColor: "#FFFFFF", TintColor: "#FFFFFF", Menu: "")
        } else {
            setNavigationBarItem(LeftTitle: "", LeftImage: "menu", CenterTitle: R.string.localizable.termsAndCondition(), CenterImage: "", RightTitle: "", RightImage: "", BackgroundColor: k.themeColor, BackgroundImage: "", TextColor: "#FFFFFF", TintColor: "#FFFFFF", Menu: "")
        }
        self.tabBarController?.tabBar.isHidden = true
        self.getProfile()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func leftClick() {
        if self.comingFrom == "signup" {
            self.navigationController?.popViewController(animated: true)
        } else {
            toggleLeft()
        }
    }
    
    func getProfile() {
        Api.shared.getProfileTerms(self, self.paramProfileTerms()) { (response) in
            let page = response.terms_condition ?? ""
            self.txtMessage.attributedText = page.htmlToAttributedString
        }
    }
    
    func paramProfileTerms() -> [String:AnyObject] {
        var dict : [String:AnyObject] = [:]
        if self.restCodeId != "" {
            dict["user_id"] = self.restCodeId as AnyObject
        } else {
            dict["user_id"] = k.userDefault.value(forKey: k.session.interestedRestId) as AnyObject
        }
        return dict
    }
}
