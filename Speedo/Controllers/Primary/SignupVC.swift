//
//  SignupVC.swift
//  Speedo
//
//  Created by mac on 18/04/21.
//

import UIKit
import CountryPickerView

class SignupVC: UIViewController {
    
    @IBOutlet var txtFirstName: UITextField!
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet var txtPhone: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet var txtPassword: UITextField!
    @IBOutlet var btnTerms: UIButton!
    @IBOutlet weak var lblUser: UILabel!
    @IBOutlet weak var lblRestaurant: UILabel!
    @IBOutlet weak var lblDriver: UILabel!
    @IBOutlet weak var txtRestaurantCode: UITextField!
    @IBOutlet weak var txtTaxNumber: UITextField!
    @IBOutlet weak var vwRestaurantCode: UIView!
    @IBOutlet weak var vwTaxNumber: UIView!
    @IBOutlet weak var txtSignIn: UITextView!
    
    var phoneKey:String = ""
    var phoneImage: UIImage?
    let cp = CountryPickerView(frame: CGRect(x: 0, y: 0, width: 120, height: 20))
    weak var cpvTextField: CountryPickerView!
    var isCheck = false
    var userType = "USER"
    var address = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureCountryView()
        Utility.getCurrentAddress { (address) in
            self.address = address
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if userType == "USER" {
            self.user()
        } else if userType == "RESTAURANT" {
            self.restaurant()
        } else {
            self.driver()
        }
        self.setUpLink()
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
        self.phoneKey = cp.selectedCountry.phoneCode
    }
    
    @IBAction func btnSignup(_ sender: UIButton) {
        if self.userType == "USER" {
            if self.txtRestaurantCode.text != "" {
                self.sendOtp()
            } else {
                Utility.showAlertMessage(withTitle: k.appName, message: "Please enter the restaurant code", delegate: nil, parentViewController: self)
            }
        } else {
            self.sendOtp()
        }
    }
    
    func sendOtp() {
        print(self.paramSendOtp())
        Api.shared.sendOtpSignUp(self, self.paramSendOtp()) { (response) in
            print(response)
            if let status = response.status, status == "1" {
                let vc = R.storyboard.main().instantiateViewController(withIdentifier: "OtpVC") as! OtpVC
                vc.modalTransitionStyle = .crossDissolve
                vc.modalPresentationStyle = .overFullScreen
                vc.dictForOtp = self.paramSendOtp()
                vc.paramSignup = self.paramSignup()
                vc.verficationCode = response.result?.code ?? 0
                vc.comingFrom = "signup"
                self.present(vc, animated: true, completion: nil)
            } else {
                Utility.showAlertMessage(withTitle: k.appName, message: response.message ?? "", delegate: nil, parentViewController: self)
            }
        }
    }
    
//    func signup() {
//        print(self.paramSignup())
//        Api.shared.signup(self, self.paramSignup(), images: [:], videos: [:]) { (response) in
//            Utility.showAlertWithAction(withTitle: k.appName, message: R.string.localizable.thankYouForRegistration(), delegate: nil, parentViewController: self) { (bool) in
//                k.userDefault.set(response.id ?? "", forKey: k.session.userId)
//                k.userDefault.set(response.firstName ?? "", forKey: k.session.userName)
//                k.userDefault.set(response.image ?? "", forKey: k.session.userImage)
//                k.userDefault.set(response.email ?? "", forKey: k.session.userEmail)
//                k.userDefault.set(response.type ?? "", forKey: k.session.userType)
//                k.userDefault.set(response.interestedRestId ?? "", forKey: k.session.interestedRestId)
//                k.userDefault.set(true, forKey: k.session.status)
//                Switcher.updateRootVC()
//            }
//        }
//    }
    
    func paramSignup() -> [String:String] {
        var dict : [String:String] = [:]
        dict["first_name"] = self.txtFirstName.text!
        dict["last_name"] = self.txtLastName.text!
        dict["mobile"] = self.txtPhone.text!
        dict["email"] = self.txtEmail.text!
        dict["password"] = self.txtPassword.text!
        dict["address"] = self.address
        dict["register_id"] = k.emptyString
        dict["ios_register_id"] = k.iosRegisterId
        dict["type"] = userType
        dict["lat"] = String(kAppDelegate.coordinate2.coordinate.latitude)
        dict["lon"] = String(kAppDelegate.coordinate2.coordinate.longitude)
        dict["interested_rest_id"] = self.txtRestaurantCode.text!
        dict["open_day"] = "Monday,Tuesday,Wednesday,Thursday,Friday,Saturday,Sunday"
        dict["open_time"] = "0:0,0:0,0:0,0:0,0:0,0:0,0:0"
        dict["close_time"] = "0:0,0:0,0:0,0:0,0:0,0:0,0:0"
        dict["rest_ope_closs_status"] = "CLOSE,CLOSE,CLOSE,CLOSE,CLOSE,CLOSE,CLOSE"
        dict["tax_number"] = self.txtTaxNumber.text!
        return dict
    }
    
    func paramSendOtp() -> [String:AnyObject] {
        var dict : [String:AnyObject] = [:]
        dict["mobile"] = self.txtPhone.text! as AnyObject
        dict["mobile_with_code"] = "\(self.phoneKey.dropFirst())\(self.txtPhone.text!)" as AnyObject
        dict["email"] = self.txtEmail.text as AnyObject
        dict["type"] = userType as AnyObject
        return dict
    }

    @IBAction func btnTerms(_ sender: UIButton) {
        if self.btnTerms.image(for: .normal) == R.image.check_box_fill_18pt() {
            self.btnTerms.setImage(R.image.check_box_nill_18pt(), for: .normal)
            self.isCheck = false
        } else {
            self.btnTerms.setImage(R.image.check_box_fill_18pt(), for: .normal)
            self.isCheck = true
        }
    }
    
    @IBAction func btnTermsCond(_ sender: UIButton) {
        let vc = R.storyboard.main().instantiateViewController(withIdentifier: "TermsCondVC") as! TermsCondVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnUser(_ sender: UIButton) {
        self.user()
    }
    
    func user() {
        self.lblUser.backgroundColor = R.color.theme_color()
        self.lblRestaurant.backgroundColor = .clear
        self.lblDriver.backgroundColor = .clear
        self.userType = "USER"
        self.vwRestaurantCode.isHidden = false
        self.vwTaxNumber.isHidden = true
    }
    
    @IBAction func btnRestaurant(_ sender: UIButton) {
        self.restaurant()
    }
    
    func restaurant() {
        self.lblUser.backgroundColor = .clear
        self.lblRestaurant.backgroundColor = R.color.theme_color()
        self.lblDriver.backgroundColor = .clear
        self.userType = "RESTAURANT"
        self.vwRestaurantCode.isHidden = true
        self.vwTaxNumber.isHidden = false
    }
    
    @IBAction func btnDriver(_ sender: UIButton) {
        self.driver()
    }
    
    func driver() {
        self.lblUser.backgroundColor = .clear
        self.lblRestaurant.backgroundColor = .clear
        self.lblDriver.backgroundColor = R.color.theme_color()
        self.userType = "DRIVER"
        self.vwRestaurantCode.isHidden = true
        self.vwTaxNumber.isHidden = false
    }
    
    func setUpLink() {
        let text = NSMutableAttributedString(string: R.string.localizable.forContinueYouNeedToAccept())
        text.addAttribute(NSAttributedString.Key.font, value: R.font.cairoBold(size: 14.0), range: NSMakeRange(0, text.length))
        
        let selectablePart = NSMutableAttributedString(string: R.string.localizable.termsAndCondition())
        selectablePart.addAttribute(NSAttributedString.Key.font, value: R.font.cairoBold(size: 17.0), range: NSMakeRange(0, selectablePart.length))
        // Add an underline to indicate this portion of text is selectable (optional)
        selectablePart.addAttribute(NSAttributedString.Key.underlineStyle, value: 1, range: NSMakeRange(0,selectablePart.length))
        selectablePart.addAttribute(NSAttributedString.Key.underlineColor, value: UIColor.blue, range: NSMakeRange(0, selectablePart.length))
        // Add an NSLinkAttributeName with a value of an url or anything else
        selectablePart.addAttribute(NSAttributedString.Key.link, value: "signin", range: NSMakeRange(0,selectablePart.length))
        selectablePart.addAttribute(NSAttributedString.Key.foregroundColor, value: R.color.linkColor(), range: NSMakeRange(0, selectablePart.length))
        
        
        // Combine the non-selectable string with the selectable string
        text.append(selectablePart)
        
        // Center the text (optional)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = NSTextAlignment.center
        text.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, text.length))
        
        // To set the link text color (optional)
        self.txtSignIn.linkTextAttributes = [NSAttributedString.Key.foregroundColor: R.color.linkColor(), NSAttributedString.Key.font: R.font.cairoBold(size: 15.0)]
        // Set the text view to contain the attributed text
        self.txtSignIn.attributedText = text
        // Disable editing, but enable selectable so that the link can be selected
        self.txtSignIn.isEditable = false
        self.txtSignIn.isSelectable = true
        // Set the delegate in order to use textView(_:shouldInteractWithURL:inRange)
        self.txtSignIn.delegate = self
    }
}

extension SignupVC: CountryPickerViewDelegate {
    
    func countryPickerView(_ countryPickerView: CountryPickerView, didSelectCountry country: Country) {
        self.phoneKey = country.phoneCode
        self.phoneImage = country.flag
        print(country.name)
        print(country.code)
    }
}

extension SignupVC: CountryPickerViewDataSource {
    
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

extension SignupVC: UITextViewDelegate {
    
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        if userType == "USER" {
            if self.txtRestaurantCode.text != "" {
                let vc = R.storyboard.main().instantiateViewController(withIdentifier: "TermsVC") as! TermsVC
                vc.restCodeId = self.txtRestaurantCode.text!
                vc.comingFrom = "signup"
                self.navigationController?.pushViewController(vc, animated: true)
            } else {
                Utility.showAlertMessage(withTitle: k.appName, message: "Please enter restaurant code", delegate: nil, parentViewController: self)
            }
        } else {
            let vc = R.storyboard.main().instantiateViewController(withIdentifier: "TermsVC") as! TermsVC
            vc.restCodeId = "1"
            vc.comingFrom = "signup"
            self.navigationController?.pushViewController(vc, animated: true)
        }
        return false
    }
}
