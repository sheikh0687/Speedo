//
//  OtpVC.swift
//  Speedo
//
//  Created by mac on 05/03/22.
//

import UIKit

class OtpVC: UIViewController {

    @IBOutlet weak var txtOtp: UITextField!
    @IBOutlet weak var lblRemainingTime: UILabel!
    @IBOutlet weak var txtResend: UITextView!
    
    var verficationCode = 0
    var paramSignup: [String: String] = [:]
    var time = 120
    var gameTimer: Timer?
    var comingFrom = ""
    var dictForOtp: [String: AnyObject] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("verification :", self.verficationCode)
        gameTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(runTimedCode), userInfo: nil, repeats: true)
        self.setUpLink(text: R.string.localizable.haveNotYouRecievedTheCode(), highlighted: R.string.localizable.resend(), textview: self.txtResend, tag: 1)
    }
    
    @objc func runTimedCode() {
        if self.time > 0 {
            self.time = self.time - 1
            if self.time > 60 {
                let sec = self.time - 60
                self.lblRemainingTime.text = "\(R.string.localizable.remainingTime()) 1 \(R.string.localizable.min()) \(sec) \(R.string.localizable.sec())"
            } else {
                self.lblRemainingTime.text = "\(R.string.localizable.remainingTime()) 0 \(R.string.localizable.min()) \(time) \(R.string.localizable.sec())"
            }
        } else {
            gameTimer?.invalidate()
            self.dismiss(animated: true, completion: nil)
        }
    }

    @IBAction func btnConfirm(_ sender: UIButton) {
        self.confirmOTP()
    }
    
    @IBAction func btnSubmit(_ sender: UIButton) {
        self.confirmOTP()
    }
    
    @IBAction func btnCancel(_ sender: UIButton) {
        gameTimer?.invalidate()
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnResend(_ sender: UIButton) {
        self.sendOtp()
    }
    
    func sendOtp() {
        Api.shared.sendOtpSignUp(self, dictForOtp) { (response) in
            print(response)
            if let status = response.status, status == "1" {
                self.verficationCode = response.result?.code ?? 0
            } else {
                Utility.showAlertMessage(withTitle: k.appName, message: response.message ?? "", delegate: nil, parentViewController: self)
            }
        }
    }
    
    func confirmOTP() {
        if self.txtOtp.text != "" {
            let otp = Int(self.txtOtp.text ?? "0") ?? 0
            if self.verficationCode == otp {
                gameTimer?.invalidate()
                self.register()
            } else {
                Utility.showAlertMessage(withTitle: k.appName, message: R.string.localizable.incorrectOTP(), delegate: nil, parentViewController: self)
            }
        } else {
            Utility.showAlertMessage(withTitle: k.appName, message: R.string.localizable.incorrectOTP(), delegate: nil, parentViewController: self)
        }
    }
    
    func register() {
        Api.shared.signup(self, self.paramSignup, images: [:], videos: [:]) { (response) in
            Utility.showAlertWithAction(withTitle: k.appName, message: R.string.localizable.thankYouForRegistration(), delegate: nil, parentViewController: self) { (bool) in
                k.userDefault.set(response.id ?? "", forKey: k.session.userId)
                k.userDefault.setValue(response.restName ?? "", forKey: k.session.restaurantName)
                k.userDefault.set(response.firstName ?? "", forKey: k.session.userName)
                k.userDefault.set(response.image ?? "", forKey: k.session.userImage)
                k.userDefault.set(response.email ?? "", forKey: k.session.userEmail)
                k.userDefault.set(response.type ?? "", forKey: k.session.userType)
                k.userDefault.set(response.interestedRestId ?? "", forKey: k.session.interestedRestId)
                k.userDefault.set(true, forKey: k.session.userLogin)
                k.userDefault.set(true, forKey: k.session.status)
                Switcher.updateRootVC()
            }
        }
    }
}


extension OtpVC {
    
    func setUpLink(text: String, highlighted: String, textview: UITextView, tag: Int) {
        let text = NSMutableAttributedString(string: text)
        text.addAttribute(NSAttributedString.Key.font, value: R.font.cairoRegular(size: 14.0), range: NSMakeRange(0, text.length))
        
        let selectablePart = NSMutableAttributedString(string: highlighted)
        selectablePart.addAttribute(NSAttributedString.Key.font, value: R.font.cairoRegular(size: 17.0), range: NSMakeRange(0, selectablePart.length))
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
        
        // To set the link text color (optional)bhn n bn b vv hgvn nn
        textview.linkTextAttributes = [NSAttributedString.Key.foregroundColor: R.color.linkColor(), NSAttributedString.Key.font: R.font.cairoRegular(size: 15.0)]
        // Set the text view to contain the attributed text
        textview.attributedText = text
        // Disable editing, but enable selectable so that the link can be selected
        textview.isEditable = false
        textview.isSelectable = true
        textview.tag = tag
        // Set the delegate in order to use textView(_:shouldInteractWithURL:inRange)
        textview.delegate = self
    }
}

extension OtpVC: UITextViewDelegate {
    
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        self.sendOtp()
        return false
    }
}
