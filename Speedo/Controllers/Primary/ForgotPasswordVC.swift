//
//  ForgotPasswordVC.swift
//  Speedo
//
//  Created by mac on 18/04/21.
//

import UIKit
import CountryPickerView

class ForgotPasswordVC: UIViewController {
    
    @IBOutlet weak var txtPhone: UITextField!
    
    var countryCode = ""
    var phoneKey:String = ""
    var phoneImage: UIImage?
    let cp = CountryPickerView(frame: CGRect(x: 0, y: 0, width: 120, height: 20))
    weak var cpvTextField: CountryPickerView!
    var type = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureCountryView()
        self.txtPhone.placeholder = "Enter Phone"
    }
    
    func configureCountryView() {
        self.txtPhone.leftView = cp
        self.txtPhone.leftViewMode = .always
        self.cpvTextField = cp
        cp.delegate = self
        [cp].forEach {
            $0?.dataSource = self
        }
        cp.countryDetailsLabel.font = UIFont.systemFont(ofSize: 13)
        cp.font = UIFont.systemFont(ofSize: 13)
    }
    
    @IBAction func btnSubmit(_ sender: UIButton) {
        self.forgotPassword()
    }
    
    func paramForgotPassword() -> [String:AnyObject] {
        var dict : [String:AnyObject] = [:]
        dict["mobile"] = self.txtPhone.text! as AnyObject
        var newMobile = ""
        if self.countryCode.count > 0 {
            newMobile = String(self.countryCode.dropFirst())
            newMobile = "\(newMobile)\(self.txtPhone.text!)"
        }
        dict["mobile_with_code"] = newMobile as AnyObject
        dict["type"] = type as AnyObject
        return dict
    }
    
    func forgotPassword() {
        print(self.paramForgotPassword())
        Api.shared.forgotPassword(self, self.paramForgotPassword()) { (response) in
            Utility.showAlertWithAction(withTitle: k.appName, message: R.string.localizable.pleaseCheckYourMobileAndCheckSMSForNewPassword(), delegate: nil, parentViewController: self) { (bool) in
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func btnClose(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension ForgotPasswordVC: CountryPickerViewDelegate {
    
    func countryPickerView(_ countryPickerView: CountryPickerView, didSelectCountry country: Country) {
        self.phoneKey = country.code
        self.phoneImage = country.flag
        self.countryCode = country.phoneCode
    }
}

extension ForgotPasswordVC: CountryPickerViewDataSource {
    
    func preferredCountries(in countryPickerView: CountryPickerView) -> [Country] {
        var countries = [Country]()
        ["NG", "US", "GB"].forEach { code in
            if let country = countryPickerView.getCountryByCode(code) {
                countries.append(country)
            }
        }
        return countries
    }
    
    func sectionTitleForPreferredCountries(in countryPickerView: CountryPickerView) -> String? {
        return "Preferred title"
    }
    
    func showOnlyPreferredSection(in countryPickerView: CountryPickerView) -> Bool {
        return false
    }
    
    func navigationTitle(in countryPickerView: CountryPickerView) -> String? {
        return "Select a Country"
    }
}
