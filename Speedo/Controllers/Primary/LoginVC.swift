//
//  LoginVC.swift
//  Speedo
//
//  Created by mac on 18/04/21.
//

import UIKit
import CountryPickerView

class LoginVC: UIViewController {
    
    @IBOutlet var txtPhone: UITextField!
    @IBOutlet var txtPassword: UITextField!
    @IBOutlet weak var lblUser: UILabel!
    @IBOutlet weak var lblRestaurant: UILabel!
    @IBOutlet weak var lblDriver: UILabel!
    
    var countryCode = ""
    var phoneKey:String = ""
    var phoneImage: UIImage?
    let cp = CountryPickerView(frame: CGRect(x: 0, y: 0, width: 120, height: 20))
    weak var cpvTextField: CountryPickerView!
    var userType = "USER"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureCountryView()
    }
    
    func configureCountryView() {
        if UIApplication.isRTL() {
            self.txtPhone.rightView = cp
            self.txtPhone.rightViewMode = .always
        } else {
            self.txtPhone.leftView = cp
            self.txtPhone.leftViewMode = .always
        }
        self.cpvTextField = cp
        cp.delegate = self
        [cp].forEach {
            $0?.dataSource = self
        }
        cp.countryDetailsLabel.font = UIFont.systemFont(ofSize: 13)
        cp.font = UIFont.systemFont(ofSize: 13)
    }
    
    @IBAction func btnLogin(_ sender: UIButton) {
        if self.txtPassword.hasText && self.txtPhone.hasText {
            login()
        } else {
            self.alert(alertmessage: R.string.localizable.pleaseEnterValidDetails())
        }
    }
    
    func paramLogin() -> [String:AnyObject] {
        var dict : [String:AnyObject] = [:]
        dict["mobile"]              =   self.txtPhone.text! as AnyObject
        dict["password"]            =   self.txtPassword.text! as AnyObject
        dict["register_id"]         =   k.emptyString as AnyObject
        dict["ios_register_id"]     =   k.iosRegisterId as AnyObject
        dict["type"] = userType as AnyObject
        return dict
    }
    
    func login() {
        Api.shared.login(self, self.paramLogin()) { (response) in
            k.userDefault.set(response.id ?? "", forKey: k.session.userId)
            k.userDefault.set(response.firstName ?? "", forKey: k.session.userName)
            k.userDefault.setValue(response.restName ?? "", forKey: k.session.restaurantName)
            k.userDefault.set(response.image ?? "", forKey: k.session.userImage)
            k.userDefault.set(response.email ?? "", forKey: k.session.userEmail)
            k.userDefault.set(response.type ?? "", forKey: k.session.userType)
            k.userDefault.set(response.interestedRestId ?? "", forKey: k.session.interestedRestId)
            k.userDefault.setValue(response.lat ?? "", forKey: k.session.lat)
            k.userDefault.setValue(response.lon ?? "", forKey: k.session.lon)
            k.userDefault.set(true, forKey: k.session.userLogin)
            k.userDefault.set(true, forKey: k.session.status)
            Switcher.updateRootVC()
        }
    }
    
    @IBAction func btnForgotPassword(_ sender: Any) {
        let vc = R.storyboard.main().instantiateViewController(withIdentifier: "ForgotPasswordVC") as! ForgotPasswordVC
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overFullScreen
        vc.type = self.userType
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func btnUser(_ sender: UIButton) {
        self.lblUser.backgroundColor = R.color.theme_color()
        self.lblRestaurant.backgroundColor = .clear
        self.lblDriver.backgroundColor = .clear
        self.userType = "USER"
    }
    
    @IBAction func btnRestaurant(_ sender: UIButton) {
        self.lblUser.backgroundColor = .clear
        self.lblRestaurant.backgroundColor = R.color.theme_color()
        self.lblDriver.backgroundColor = .clear
        self.userType = "RESTAURANT"
    }
    
    @IBAction func btnDriver(_ sender: UIButton) {
        self.lblUser.backgroundColor = .clear
        self.lblRestaurant.backgroundColor = .clear
        self.lblDriver.backgroundColor = R.color.theme_color()
        self.userType = "DRIVER"
    }
}


extension LoginVC: CountryPickerViewDelegate {
    
    func countryPickerView(_ countryPickerView: CountryPickerView, didSelectCountry country: Country) {
        self.phoneKey = country.code
        self.phoneImage = country.flag
        self.countryCode = country.phoneCode
    }
}

extension LoginVC: CountryPickerViewDataSource {
    
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
