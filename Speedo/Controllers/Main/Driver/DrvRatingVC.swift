//
//  DrvRatingVC.swift
//  Speedo
//
//  Created by mac on 24/05/21.
//

import UIKit
import Cosmos

class DrvRatingVC: UIViewController {

    @IBOutlet weak var vwCosmos: CosmosView!
    @IBOutlet weak var txtComments: UITextView!
    
    var deliveryStatus = ""
    var orderRequestId = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.txtComments.textColor = .lightGray
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBarItem(LeftTitle: "", LeftImage: "back", CenterTitle: R.string.localizable.giveRating(), CenterImage: "", RightTitle: "", RightImage: "", BackgroundColor: k.themeColor, BackgroundImage: "", TextColor: "#FFFFFF", TintColor: "#FFFFFF", Menu: "")
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    @IBAction func btnSubmit(_ sender: UIButton) {
        self.changeDeliveryStatus()
    }
    
    func paramChangeDeliveryStatus() -> [String:AnyObject] {
        var dict : [String:AnyObject] = [:]
        dict["driver_id"] = k.userDefault.value(forKey: k.session.userId)! as AnyObject
        dict["delivery_status"] = self.deliveryStatus as AnyObject
        dict["order_request_id"] = self.orderRequestId as AnyObject
        dict["rating"] = String(self.vwCosmos.rating) as AnyObject
        dict["review"] = self.txtComments.text! as AnyObject
        dict["type"] = "Driver" as AnyObject
        return dict
    }
    
    func changeDeliveryStatus() {
        print(self.paramChangeDeliveryStatus())
        Api.shared.drvDeliveryStatus(self, self.paramChangeDeliveryStatus()) { (response) in
            Utility.showAlertWithAction(withTitle: k.appName, message: R.string.localizable.ratingAddedSuccessfully(), delegate: nil, parentViewController: self) { (response) in
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
}

extension DrvRatingVC: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if (textView.text == "Enter Your Comments" && textView.textColor == .lightGray) {
            textView.text = ""
            textView.textColor = .black
        }
        textView.becomeFirstResponder() //Optional
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if (textView.text == "" && textView.tag == 0) {
            textView.text = "Enter Your Comments"
            textView.textColor = .lightGray
        }
        textView.resignFirstResponder()
    }
}
