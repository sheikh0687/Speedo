//
//  BusinessCodeVC.swift
//  Speedo
//
//  Created by mac on 09/05/22.
//

import UIKit

class BusinessCodeVC: UIViewController {

    @IBOutlet weak var txtBusinessCode: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        self.getGuestProfile()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    func getGuestProfile() {
        Api.shared.getGuestProfile(self) { (response) in
            if let guestStatus = response.guest_user_status, guestStatus == "Yes" {
                self.txtBusinessCode.text = "16"
            }
        }
    }

    @IBAction func btnSubmit(_ sender: UIButton) {
        if self.txtBusinessCode.hasText {
            k.userDefault.set(self.txtBusinessCode.text ?? "", forKey: k.session.interestedRestId)
            k.userDefault.set(true, forKey: k.session.status)
            k.userDefault.setValue("51", forKey: k.session.userId)
            k.userDefault.set(false, forKey: k.session.userLogin)
            Switcher.logToGuest()
        } else {
            Utility.showAlertMessage(withTitle: k.appName, message: R.string.localizable.enterYourBusinessCode(), delegate: nil, parentViewController: self)
        }
    }
        
    @IBAction func btnSignup(_ sender: UIButton) {
        let vc = R.storyboard.main().instantiateViewController(withIdentifier: "PrimaryMainVC") as! PrimaryMainVC
        vc.form = "signup"
        vc.type = "USER"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}
