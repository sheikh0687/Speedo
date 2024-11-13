//
//  PrimaryMainVC.swift
//  Speedo
//
//  Created by mac on 18/04/21.
//

import UIKit

class PrimaryMainVC: UIViewController {

    @IBOutlet weak var vwSignup: UIView!
    @IBOutlet weak var vwLogin: UIView!
    @IBOutlet weak var lblLogin: UILabel!
    @IBOutlet weak var lblSignup: UILabel!
    
    var form = ""
    var type = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.form == "Login" {
            self.login()
        } else {
            self.signUp()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.isHidden = true
        print(self.type)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    @IBAction func btnLogin(_ sender: UIButton) {
        self.login()
    }
    
    func login() {
        self.lblLogin.isHidden = false
        self.lblSignup.isHidden = true
        self.vwLogin.isHidden = false
        self.vwSignup.isHidden = true
    }
    
    @IBAction func btnSignup(_ sender: UIButton) {
        self.signUp()
    }
    
    func signUp() {
        self.lblLogin.isHidden = true
        self.lblSignup.isHidden = false
        self.vwLogin.isHidden = true
        self.vwSignup.isHidden = false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "signup") {
            let vc = segue.destination as! SignupVC
            vc.userType = self.type
        }
    }
    
    @IBAction func btnBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}

