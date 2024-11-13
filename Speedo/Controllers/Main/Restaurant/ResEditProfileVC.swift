//
//  DrvEditProfileVC.swift
//  Speedo
//
//  Created by mac on 21/04/21.
//

import UIKit

class ResEditProfileVC: UIViewController {

    @IBOutlet var btnProfile: UIButton!
    @IBOutlet weak var btnUpdateRes: UIButton!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblMobile: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    
    var image = UIImage()
    var comingFrom = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBarItem(LeftTitle: "", LeftImage: "menu", CenterTitle: R.string.localizable.myProfile(), CenterImage: "", RightTitle: "", RightImage: "pencil", BackgroundColor: k.themeColor, BackgroundImage: "", TextColor: "#FFFFFF", TintColor: "#FFFFFF", Menu: "")
        self.getProfile()
        if comingFrom == "User" || comingFrom == "Driver" {
            self.btnUpdateRes.isHidden = true
        } else {
            self.btnUpdateRes.isHidden = false
        }
    }
    
    override func leftClick() {
        toggleLeft()
    }
    
    override func rightClick() {
        let vc = R.storyboard.main().instantiateViewController(withIdentifier: "EditProfileVC") as! EditProfileVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func getProfile() {
        Api.shared.getProfile(self) { (response) in
            self.lblUserName.text = "\(response.firstName ?? "") \(response.lastName ?? "")"
            self.lblMobile.text = response.mobile ?? ""
            self.lblAddress.text = response.address ?? ""
            if let img = response.restImage, img != "" {
                Utility.downloadImageBySDWebImage(img) { (image, error) in
                    self.btnProfile.setImage(image, for: .normal)
                }
            }
        }
    }
    
    @IBAction func btnChangePassword(_ sender: UIButton) {
        let vc = R.storyboard.main().instantiateViewController(withIdentifier: "ChangePasswordVC") as! ChangePasswordVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnUpdateProfile(_ sender: UIButton) {
        let vc = R.storyboard.main().instantiateViewController(withIdentifier: "ResUpdateVC") as! ResUpdateVC
        self.navigationController?.pushViewController(vc, animated: true)
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
    
    @IBAction func btnDeleteAccount(_ sender: UIButton) {
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
}
