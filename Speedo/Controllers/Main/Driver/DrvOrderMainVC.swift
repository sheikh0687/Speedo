//
//  DrvOrderMainVC.swift
//  Speedo
//
//  Created by mac on 21/04/21.
//

import UIKit

class DrvOrderMainVC: UIViewController {

    @IBOutlet var vwCurrent: UIView!
    @IBOutlet var vwPast: UIView!
    @IBOutlet var lblCurrent: UILabel!
    @IBOutlet var lblPast: UILabel!
    @IBOutlet var btnCurrent: UIButton!
    @IBOutlet var btnPast: UIButton!
    
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
    }
    
    override func leftClick() {
        toggleLeft()
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
}

