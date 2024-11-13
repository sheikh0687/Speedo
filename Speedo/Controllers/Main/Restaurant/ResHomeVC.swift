//
//  DrvHomeVC.swift
//  Speedo
//
//  Created by mac on 21/04/21.
//

import UIKit

class ResHomeVC: UIViewController {

    @IBOutlet var vwOpen: UIView!
    @IBOutlet var vwCurrent: UIView!
    @IBOutlet var vwPast: UIView!
    @IBOutlet var lblOpen: UILabel!
    @IBOutlet var lblCurrent: UILabel!
    @IBOutlet var lblPast: UILabel!
    @IBOutlet var btnOpen: UIButton!
    @IBOutlet var btnCurrent: UIButton!
    @IBOutlet var btnPast: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lblOpen.isHidden = false
        self.lblCurrent.isHidden = true
        self.lblPast.isHidden = true
        self.vwOpen.isHidden = false
        self.vwCurrent.isHidden = true
        self.vwPast.isHidden = true
        if let restaurantName = k.userDefault.value(forKey: k.session.restaurantName) as? String, restaurantName == "" {
            Utility.showAlertYesNoActionCust(withTitle: R.string.localizable.addDetails(), message: R.string.localizable.pleaseUpdateYourRestaurantDetailsFromUpdateRestaurantScreen(), delegate: nil, parentViewController: self) { (boool) in
                if boool {
                    let vc = R.storyboard.main().instantiateViewController(withIdentifier: "ResUpdateVC") as! ResUpdateVC
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBarItem(LeftTitle: "", LeftImage: "menu", CenterTitle: R.string.localizable.orders(), CenterImage: "", RightTitle: "", RightImage: "", BackgroundColor: k.themeColor, BackgroundImage: "", TextColor: "#FFFFFF", TintColor: "#FFFFFF", Menu: "")
        print(k.userDefault.value(forKey: k.session.userId))
    }
    
    override func leftClick() {
        toggleLeft()
    }
    
    @IBAction func btnOpen(_ sender: Any) {
        self.lblOpen.isHidden = false
        self.lblCurrent.isHidden = true
        self.lblPast.isHidden = true
        self.vwOpen.isHidden = false
        self.vwCurrent.isHidden = true
        self.vwPast.isHidden = true
    }
    
    @IBAction func btnCurrent(_ sender: Any) {
        self.lblOpen.isHidden = true
        self.vwOpen.isHidden = true
        self.lblCurrent.isHidden = false
        self.lblPast.isHidden = true
        self.vwCurrent.isHidden = false
        self.vwPast.isHidden = true
    }
    
    @IBAction func btnPast(_ sender: UIButton) {
        self.lblOpen.isHidden = true
        self.vwOpen.isHidden = true
        self.lblCurrent.isHidden = true
        self.lblPast.isHidden = false
        self.vwCurrent.isHidden = true
        self.vwPast.isHidden = false
    }
}

