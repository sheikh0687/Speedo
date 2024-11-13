//
//  EditProfileVC.swift
//  Speedo
//
//  Created by mac on 18/04/21.
//

import UIKit

class EditProfileVC: UIViewController {

    @IBOutlet var btnProfile: UIButton!
    @IBOutlet var txtUserName: UITextField!
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet var txtMobile: UITextField!
    @IBOutlet var btnSave: UIButton!
    
    var image = UIImage()
    var comingFrom = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBarItem(LeftTitle: "", LeftImage: "menu", CenterTitle: R.string.localizable.myProfile(), CenterImage: "", RightTitle: "", RightImage: "", BackgroundColor: k.themeColor, BackgroundImage: "", TextColor: "#FFFFFF", TintColor: "#FFFFFF", Menu: "")
//        if self.comingFrom == "user" {
//
//        } else {
//            setNavigationBarItem(LeftTitle: "", LeftImage: "back", CenterTitle: "My Profile", CenterImage: "", RightTitle: "", RightImage: "", BackgroundColor: k.themeColor, BackgroundImage: "", TextColor: "#FFFFFF", TintColor: "#FFFFFF", Menu: "")
//        }
        self.tabBarController?.tabBar.isHidden = true
        self.getProfile()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func leftClick() {
        toggleLeft()
//        if self.comingFrom == "user" {
//            
//        } else {
//            self.navigationController?.popViewController(animated: true)
//        }
    }
    
    override func rightClick() {
        let vc = R.storyboard.main().instantiateViewController(withIdentifier: "CartVC") as! CartVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func getProfile() {
        Api.shared.getProfile(self) { (response) in
            dump(response)
            self.txtUserName.text = response.firstName ?? ""
            self.txtLastName.text = response.lastName ?? ""
            self.txtMobile.text = response.mobile ?? ""
            if let image = response.image, image != Router.BASE_IMAGE_URL {
                Utility.downloadImageBySDWebImage(response.image ?? "") { (image, error) in
                    if error == nil {
                        self.btnProfile.setImage(image, for: .normal)
                    }
                }
            }
        }
    }
    
    @IBAction func btnSave(_ sender: UIButton) {
        Api.shared.updateProfile(self, self.paramSignup(), images: self.imageUpdateProfile(), videos: [:]) { (response) in
            k.userDefault.set(response.id ?? "", forKey: k.session.userId)
            k.userDefault.setValue(response.restName ?? "", forKey: k.session.restaurantName)
            k.userDefault.set("\(response.firstName ?? "") \(response.lastName ?? "")", forKey: k.session.userName)
            k.userDefault.set(response.image ?? "", forKey: k.session.userImage)
            k.userDefault.set(response.email ?? "", forKey: k.session.userEmail)
            k.userDefault.set(response.type ?? "", forKey: k.session.userType)
            k.userDefault.set(response.interestedRestId ?? "", forKey: k.session.interestedRestId)
            Utility.showAlertWithAction(withTitle: k.appName, message: R.string.localizable.profileUpdateSuccessfully(), delegate: nil, parentViewController: self) { (bool) in                
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    func paramSignup() -> [String:String] {
        var dict : [String:String] = [:]
        dict["user_id"] = k.userDefault.value(forKey: k.session.userId) as? String
        dict["first_name"] = self.txtUserName.text!
        dict["last_name"] = self.txtLastName.text!
        dict["mobile"] = self.txtMobile.text!
        dict["ios_register_id"] = k.iosRegisterId
        return dict
    }
    
    func imageUpdateProfile() -> [String:UIImage] {
        var dict : [String:UIImage] = [:]
        dict["image"] = self.image
        return dict
    }
    
    @IBAction func btnProfile(_ sender: UIButton) {
        CameraHandler.shared.showActionSheet(vc: self)
        CameraHandler.shared.imagePickedBlock = { (image) in
            self.image = image
            sender.contentMode = .scaleToFill
            sender.setImage(image, for: .normal)
        }
    }
}
