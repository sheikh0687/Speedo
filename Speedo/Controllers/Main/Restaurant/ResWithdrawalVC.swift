//
//  DrvWithdrawalVC.swift
//  Speedo
//
//  Created by mac on 21/04/21.
//

import UIKit

class ResWithdrawalVC: UIViewController {

    @IBOutlet weak var txtWithdrawAmount: UITextField!
    @IBOutlet weak var txtAccountHolderName: UITextField!
    @IBOutlet weak var txtIbanCode: UITextField!
    @IBOutlet weak var txtBankName: UITextField!
    
    var amount = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBarItem(LeftTitle: "", LeftImage: "back", CenterTitle: R.string.localizable.withdrawWalletAmount(), CenterImage: "", RightTitle: "", RightImage: "", BackgroundColor: k.themeColor, BackgroundImage: "", TextColor: "#FFFFFF", TintColor: "#FFFFFF", Menu: "")
    }
    
    @IBAction func btnSubmit(_ sender: UIButton) {
        Api.shared.withdrawalAmount(self, self.paramWithdrawMoney()) { (response) in
            Utility.showAlertWithAction(withTitle: k.appName, message: R.string.localizable.requestForWithdrawalSendSuccessfully(), delegate: nil, parentViewController: self) { (boool) in
                Switcher.updateRootVC()
            }
        }
    }
    
    func paramWithdrawMoney() -> [String:AnyObject] {
        var dict : [String:AnyObject] = [:]
        dict["user_id"] = k.userDefault.value(forKey: k.session.userId) as AnyObject
        dict["amount"] = self.txtWithdrawAmount.text as AnyObject
        dict["branch"] = k.emptyString as AnyObject
        dict["account_holder_name"] = self.txtAccountHolderName.text as AnyObject
        dict["account_number"] = k.emptyString as AnyObject
        dict["ifsc_code"] = self.txtIbanCode.text as AnyObject
        dict["description"] = k.emptyString as AnyObject
        return dict
    }
}
