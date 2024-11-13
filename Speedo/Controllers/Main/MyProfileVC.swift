//
//  MyProfileVC.swift
//  Speedo
//
//  Created by mac on 18/04/21.
//

import UIKit

class MyProfileVC: UIViewController {

    @IBOutlet var lblName: UILabel!
    @IBOutlet var lblMobile: UILabel!
    @IBOutlet var imgProfile: UIButton!
    @IBOutlet weak var lblAddress: UILabel!
    
    @IBOutlet weak var lblTotalCart: UILabel!
    @IBOutlet weak var lblTotalCount: UILabel!
    @IBOutlet weak var vwCart: UIView!
    
    var comingFrom = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBarItem(LeftTitle: "", LeftImage: "menu", CenterTitle: R.string.localizable.myProfile(), CenterImage: "", RightTitle: "", RightImage: "pencil", BackgroundColor: k.themeColor, BackgroundImage: "", TextColor: "#FFFFFF", TintColor: "#FFFFFF", Menu: "")
        if Utility.isUserLogin() {
            self.getProfile()
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
    
    override func rightClick() {
        if let userType = k.userDefault.value(forKey: k.session.userType) as? String, userType == "USER" {
            let vc = R.storyboard.main().instantiateViewController(withIdentifier: "EditProfileVC") as! EditProfileVC
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            let vc = R.storyboard.main().instantiateViewController(withIdentifier: "ResEditProfileVC") as! ResEditProfileVC
            vc.comingFrom = "User"
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func getProfile() {
        Api.shared.getProfile(self) { (response) in
            self.lblName.text = "\(response.firstName ?? "") \(response.lastName ?? "")"
            self.lblMobile.text = response.mobile ?? ""
            self.lblAddress.text = response.address ?? ""
            if let image = response.image, image != Router.BASE_IMAGE_URL {
                Utility.downloadImageBySDWebImage(response.image ?? "") { (image, error) in
                    if error == nil {
                        self.imgProfile.setImage(image, for: .normal)
                    }
                }
            }
        }
    }
    
    @IBAction func btnChangePassword(_ sender: UIButton) {
        let vc = R.storyboard.main().instantiateViewController(withIdentifier: "ChangePasswordVC") as! ChangePasswordVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func DeleteAccount(_ sender: UIButton) {
        Utility.showAlertYesNoAction(withTitle: k.appName, message: R.string.localizable.areYouSureYouWantToDeleteAccount(), delegate: nil, parentViewController: self) { boool in
            if boool {
                Api.shared.deleteAccount(self) { responseData in
                    let domain = Bundle.main.bundleIdentifier!
                    UserDefaults.standard.removePersistentDomain(forName: domain)
                    UserDefaults.standard.synchronize()
                    Switcher.updateRootVC()
                }
            }
        }
    }
    
    @IBAction func btnLogout(_ sender: UIButton) {
        self.logout()
    }
    
    func logout() {
        let alertController = UIAlertController(title: k.appName, message: R.string.localizable.areYouSureYouWantToLogOut(), preferredStyle: .alert)
        let yesAction: UIAlertAction = UIAlertAction(title: R.string.localizable.yes(), style: .default) { action -> Void in
            let domain = Bundle.main.bundleIdentifier!
            UserDefaults.standard.removePersistentDomain(forName: domain)
            UserDefaults.standard.synchronize()
            Switcher.updateRootVC()
        }
        let noAction: UIAlertAction = UIAlertAction(title: R.string.localizable.no(), style: .cancel) { action -> Void in
            //Just dismiss the action sheet
        }
        alertController.addAction(yesAction)
        alertController.addAction(noAction)
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func btnCart(_ sender: UIButton) {
        let vc = R.storyboard.main().instantiateViewController(withIdentifier: "CartVC") as! CartVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
