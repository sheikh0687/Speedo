//
//  LandingVC.swift
//  Speedo
//
//  Created by mac on 09/05/22.
//

import UIKit

class LandingVC: UIViewController {
    
    @IBOutlet weak var btnUser: UIButton!
    @IBOutlet weak var btnRestaurant: UIButton!
    @IBOutlet weak var btnDriver: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    @IBAction func btnContinueAsUser(_ sender: UIButton) {
        let vc = R.storyboard.main().instantiateViewController(withIdentifier: "BusinessCodeVC") as! BusinessCodeVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnContinueAsRestaurant(_ sender: UIButton) {
        let vc = R.storyboard.main().instantiateViewController(withIdentifier: "PrimaryMainVC") as! PrimaryMainVC
        vc.type = "RESTAURANT"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnDriver(_ sender: UIButton) {
        let vc = R.storyboard.main().instantiateViewController(withIdentifier: "PrimaryMainVC") as! PrimaryMainVC
        vc.type = "DRIVER"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnLogin(_ sender: UIButton) {
        let vc = R.storyboard.main().instantiateViewController(withIdentifier: "PrimaryMainVC") as! PrimaryMainVC
        vc.form = "Login"
        vc.type = "USER"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
