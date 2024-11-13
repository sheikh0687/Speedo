//
//  OrderMainVC.swift
//  Speedo
//
//  Created by mac on 18/04/21.
//

import UIKit

class OrderMainVC: UIViewController {

    @IBOutlet var vwCurrent: UIView!
    @IBOutlet var vwPast: UIView!
    @IBOutlet var lblCurrent: UILabel!
    @IBOutlet var lblPast: UILabel!
    @IBOutlet var btnCurrent: UIButton!
    @IBOutlet var btnPast: UIButton!
    @IBOutlet weak var lblTotalCart: UILabel!
    @IBOutlet weak var lblTotalCount: UILabel!
    @IBOutlet weak var vwCart: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lblCurrent.isHidden = false
        self.lblPast.isHidden = true
        self.vwCurrent.isHidden = false
        self.vwPast.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBarItem(LeftTitle: "", LeftImage: "menu", CenterTitle: R.string.localizable.orders(), CenterImage: "", RightTitle: "", RightImage: "", BackgroundColor: k.themeColor, BackgroundImage: "", TextColor: "#FFFFFF", TintColor: "#FFFFFF", Menu: "")
        if Utility.isUserLogin() {
            self.getCart()
        }
    }
    
    override func leftClick() {
        toggleLeft()
    }
    
    func getCart() {
        Api.shared.getCart(self) { (response) in
            if let cartCount = response.totalCart, cartCount != "" {
                self.vwCart.isHidden = false
                self.lblTotalCart.text = "\(R.string.localizable.totalCart()) (\(k.currency) \(response.totalAmount ?? ""))"
                self.lblTotalCount.text = response.totalCart ?? ""
            } else {
                self.vwCart.isHidden = true
            }
        }
    }
    
    @IBAction func btnPast(_ sender: UIButton) {
        self.lblCurrent.isHidden = true
        self.lblPast.isHidden = false
        self.vwCurrent.isHidden = true
        self.vwPast.isHidden = false
    }
    
    @IBAction func btnCurrent(_ sender: Any) {
        self.lblCurrent.isHidden = false
        self.lblPast.isHidden = true
        self.vwCurrent.isHidden = false
        self.vwPast.isHidden = true
    }
    
    override func rightClick() {
        let vc = R.storyboard.main().instantiateViewController(withIdentifier: "CartVC") as! CartVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnCart(_ sender: UIButton) {
        let vc = R.storyboard.main().instantiateViewController(withIdentifier: "CartVC") as! CartVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
