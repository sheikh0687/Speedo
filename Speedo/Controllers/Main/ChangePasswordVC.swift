//
//  ChangePasswordVC.swift
//  Speedo
//
//  Created by mac on 26/05/21.
//

import UIKit

class ChangePasswordVC: UIViewController {

    @IBOutlet var txtOldPassword: UITextField!
    @IBOutlet var txtNewPassword: UITextField!
    @IBOutlet var txtConfirmPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBarItem(LeftTitle: "", LeftImage: "back", CenterTitle: R.string.localizable.changePassword(), CenterImage: "", RightTitle: "", RightImage: "", BackgroundColor: k.themeColor, BackgroundImage: "", TextColor: "#FFFFFF", TintColor: "#FFFFFF", Menu: "")
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    func paramChangePassword() -> [String:AnyObject] {
        var dict : [String:AnyObject] = [:]
        dict["user_id"] = k.userDefault.value(forKey: k.session.userId)! as AnyObject
        dict["old_password"] = self.txtOldPassword.text! as AnyObject
        dict["password"] = self.txtNewPassword.text! as AnyObject
        return dict
    }
    
    @IBAction func btnSubmit(_ sender: UIButton) {
        if isValidInput() {
            Api.shared.setPassword(self, self.paramChangePassword()) { (response) in
                Utility.showAlertWithAction(withTitle: k.appName, message: R.string.localizable.passwordChangedSuccessfully(), delegate: nil, parentViewController: self) { (bool) in
                    Switcher.updateRootVC()
                }
            }
        }
    }
    
    @IBAction func btnBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func isValidInput() -> Bool {
        var isValid : Bool = true;
        var errorMessage : String = ""
        if (self.txtOldPassword.text?.isEmpty)! {
            isValid = false
            errorMessage = R.string.localizable.pleaseEnterPassword()
            self.txtOldPassword.becomeFirstResponder()
        }
        else if (self.txtNewPassword.text?.isEmpty)!{
            isValid = false
            errorMessage = R.string.localizable.pleaseEnterPassword()
            self.txtNewPassword.becomeFirstResponder()
        }
        else if (self.txtConfirmPassword.text?.isEmpty)!{
            isValid = false
            errorMessage = R.string.localizable.pleaseEnterConfirmPassword()
            txtConfirmPassword.becomeFirstResponder()
        }
        else if self.txtNewPassword.text != txtConfirmPassword.text {
            isValid = false
            errorMessage = R.string.localizable.passwordNotMatched()
            txtNewPassword.text = ""
            txtConfirmPassword.text = ""
            txtNewPassword.becomeFirstResponder()
        }
        if (isValid == false) {
            Utility.showAlertMessage(withTitle: k.appName,
                                     message: errorMessage,
                                     delegate: nil,
                                     parentViewController: self)
        }
        return isValid
    }
}

