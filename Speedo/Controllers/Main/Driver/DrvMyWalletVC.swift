//
//  MyWalletVC.swift
//  Speedo
//
//  Created by mac on 21/04/21.
//

import UIKit

class DrvMyWalletVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBarItem(LeftTitle: "", LeftImage: "menu", CenterTitle: R.string.localizable.myWallet(), CenterImage: "", RightTitle: "", RightImage: "", BackgroundColor: k.themeColor, BackgroundImage: "", TextColor: "#FFFFFF", TintColor: "#FFFFFF", Menu: "")
    }
    
    override func leftClick() {
        toggleLeft()
    }
    
    @IBAction func btnWithdraw(_ sender: UIButton) {
        let vc = R.storyboard.main().instantiateViewController(withIdentifier: "ResWithdrawalVC") as! ResWithdrawalVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
