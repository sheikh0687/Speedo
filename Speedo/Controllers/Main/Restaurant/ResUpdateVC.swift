//
//  ResUpdateVC.swift
//  Speedo
//
//  Created by mac on 07/09/21.
//

import UIKit
import MapKit

class ResUpdateVC: UIViewController {
    
    @IBOutlet weak var btnDeliveryOption: UISwitch!
    @IBOutlet weak var tableViewOt: UITableView!
    @IBOutlet weak var constraintTableHeight: NSLayoutConstraint!
    @IBOutlet weak var txtRestName: UITextField!
    @IBOutlet weak var txtNetsSecretKey: UITextField!
    @IBOutlet weak var txtTaxNumber: UITextField!
    @IBOutlet weak var btnLocation: UIButton!
    @IBOutlet weak var txtRestDesc: UITextField!
    @IBOutlet weak var btnRestImage: UIButton!
    @IBOutlet weak var btnAddRestCoverImage: UIButton!
    
    var image = UIImage()
    var image1 = UIImage()
    var address = ""
    var lat = 0.0
    var lon = 0.0
    var location_cordinate:CLLocationCoordinate2D?
    
    var identifier = "RestUpdProfileCell"
    var arr:[RestDayDetail] = []
    var arrStatus = [String]()
    var arrDays = [String]()
    var arrOpenTime = [String]()
    var arrCloseTime = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableViewOt.register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBarItem(LeftTitle: "", LeftImage: "back", CenterTitle: R.string.localizable.restaurant(), CenterImage: "", RightTitle: "", RightImage: "", BackgroundColor: k.themeColor, BackgroundImage: "", TextColor: "#FFFFFF", TintColor: "#FFFFFF", Menu: "")
        self.tabBarController?.tabBar.isHidden = true
        self.getRestProfile()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    func getRestProfile() {
        Api.shared.restGetProfile(self, self.paramRestProfile()) { (response) in
            if response.restDayDetails?.count ?? 0 > 0 {
                self.arr = response.restDayDetails ?? []
                self.constraintTableHeight.constant = CGFloat((self.arr.count * 50))
            } else {
                self.arr = []
                self.constraintTableHeight.constant = 0
            }
            if let deliveryOption = response.deliveryOption, deliveryOption == "Yes" {
                self.btnDeliveryOption.isOn = true
            } else {
                self.btnDeliveryOption.isOn = false
            }
            self.btnLocation.setTitle(response.address ?? "", for: .normal)
            self.btnLocation.setTitleColor(.black, for: .normal)
            self.txtRestName.text = response.restName ?? ""
            self.txtTaxNumber.text = response.taxNumber ?? ""
            self.txtRestDesc.text = response.aboutMe ?? ""
            self.txtNetsSecretKey.text = response.netsPaymentKey ?? ""
            if let restImage = response.restImage, restImage != "" {
                let resImg = Router.BASE_IMAGE_URL + restImage
                Utility.downloadImageBySDWebImage(resImg) { (image, error) in
                    self.btnRestImage.setImage(image, for: .normal)
                }
            }
            if let restCoverImage = response.restCoverImage, restCoverImage != "" {
                let restCoverImg = Router.BASE_IMAGE_URL + restCoverImage
                Utility.downloadImageBySDWebImage(restCoverImg) { (image, error) in
                    self.btnAddRestCoverImage.setImage(image, for: .normal)
                }
            }
            if let arr = response.restDayDetails {
                for val in arr {
                    self.arrDays.append(val.openDay ?? "")
                    self.arrStatus.append(val.restOpeClossStatus ?? "")
                    self.arrOpenTime.append(val.openTime ?? "")
                    self.arrCloseTime.append(val.closeTime ?? "")
                }
            }
            self.tableViewOt.reloadData()
        }
    }
    
    func paramRestProfile() -> [String:AnyObject] {
        var dict : [String:AnyObject] = [:]
        dict["rest_id"] = k.userDefault.value(forKey: k.session.userId) as AnyObject
        dict["user_id"] = k.userDefault.value(forKey: k.session.userId) as AnyObject
        dict["timezone"] = localTimeZoneIdentifier as AnyObject
        dict["now_current_day"] = Utility.getCurrentDay() as AnyObject
        return dict
    }
    
    @IBAction func btnSave(_ sender: UIButton) {
        Api.shared.restUpdate(self, self.paramUpdate(), images: self.imageDictUpdate(), videos: [:]) { (response) in
            k.userDefault.set(response.id ?? "", forKey: k.session.userId)
            k.userDefault.setValue(response.restName ?? "", forKey: k.session.restaurantName)
            k.userDefault.set(response.firstName ?? "", forKey: k.session.userName)
            k.userDefault.set(response.image ?? "", forKey: k.session.userImage)
            k.userDefault.set(response.email ?? "", forKey: k.session.userEmail)
            k.userDefault.set(response.type ?? "", forKey: k.session.userType)
            k.userDefault.set(response.interestedRestId ?? "", forKey: k.session.interestedRestId)
            Utility.showAlertWithAction(withTitle: k.appName, message:
                                            R.string.localizable.profileUpdateSuccessfully(), delegate: nil, parentViewController: self) { (bool) in
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    func paramUpdate() -> [String:String] {
        var dict : [String:String] = [:]
        dict["rest_id"] = k.userDefault.value(forKey: k.session.userId) as? String
        dict["rest_name"] = self.txtRestName.text!
        dict["about_me"] = self.txtRestDesc.text!
        dict["address"] = self.address
        dict["lat"] = String(self.lat)
        dict["lon"] = String(self.lon)
        dict["rest_ope_closs_status"] = self.arrStatus.joined(separator: ",")
        dict["open_day"] = self.arrDays.joined(separator: ",")
        dict["open_time"] = self.arrOpenTime.joined(separator: ",")
        dict["close_time"] = self.arrCloseTime.joined(separator: ",")
        dict["tax_number"] = self.txtTaxNumber.text!
        dict["nets_payment_key"] = self.txtNetsSecretKey.text!
        return dict
    }
    
    func imageDictUpdate() -> [String: UIImage] {
        var dict : [String: UIImage] = [:]
        dict["rest_image"] = self.image
        dict["rest_cover_image"] = self.image1
        return dict
    }
    
    @IBAction func btnAddRestImage(_ sender: UIButton) {
        CameraHandler.shared.showActionSheet(vc: self)
        CameraHandler.shared.imagePickedBlock = { (image) in
            self.image = image
            sender.contentMode = .scaleToFill
            sender.setImage(image, for: .normal)
        }
    }
    
    @IBAction func btnAddRestCoverImage(_ sender: UIButton) {
        CameraHandler.shared.showActionSheet(vc: self)
        CameraHandler.shared.imagePickedBlock = { (image) in
            self.image1 = image
            sender.contentMode = .scaleToFill
            sender.setImage(image, for: .normal)
        }
    }
    
    @IBAction func btnDeliveryOption(_ sender: UISwitch) {
        if sender.isOn {
            Api.shared.updateDeliveryOption(self, self.paramUpdateDelivery("Yes")) { (response) in
                if let deliveryOption = response.deliveryOption, deliveryOption == "Yes" {
                    self.btnDeliveryOption.isOn = true
                } else {
                    self.btnDeliveryOption.isOn = false
                }
            }
        } else {
            Api.shared.updateDeliveryOption(self, self.paramUpdateDelivery("No")) { (response) in
                if let deliveryOption = response.deliveryOption, deliveryOption == "Yes" {
                    self.btnDeliveryOption.isOn = true
                } else {
                    self.btnDeliveryOption.isOn = false
                }
            }
        }
    }
    
    func paramUpdateDelivery(_ deliveryOption: String) -> [String:AnyObject] {
        var dict : [String:AnyObject] = [:]
        dict["user_id"] = k.userDefault.value(forKey: k.session.userId) as AnyObject
        dict["delivery_option"] = deliveryOption as AnyObject
        return dict
    }
    
    @IBAction func btnLocation(_ sender: UIButton) {
        let vc = R.storyboard.main().instantiateViewController(withIdentifier: "AddressPickerVC") as! AddressPickerVC
        vc.locationPickedBlock = { (location_coordinate, lat, lon, address) in
            self.lat = lat
            self.lon = lon
            self.address = address
            self.location_cordinate = location_coordinate
            self.btnLocation.setTitle(address, for: .normal)
        }
        self.present(vc, animated: true, completion: nil)
    }
}

extension ResUpdateVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.restUpdProfileCell, for: indexPath)!
        let obj = self.arr[indexPath.row]
        cell.lblDay.text = obj.openDay ?? ""
        cell.btnOpenTime.setTitle(obj.openTime ?? "", for: .normal)
        cell.btnCloseTime.setTitle(obj.closeTime ?? "", for: .normal)
        cell.btnStatus.setTitle(obj.restOpeClossStatus ?? "", for: .normal)
        
        if let status = obj.restOpeClossStatus, status == "OPEN" {
            cell.btnStatus.backgroundColor = R.color.theme_color()
        } else {
            cell.btnStatus.backgroundColor = .lightGray
        }
        
        cell.cloOpen = {(status) in
            self.arrStatus[indexPath.row] = status
        }
        
        cell.cloOpenTime = {() in
            let vc = R.storyboard.main().instantiateViewController(withIdentifier: "ResChooseTimeVC") as! ResChooseTimeVC
            vc.cloSelect = {(time) in
                cell.btnOpenTime.setTitle(time, for: .normal)
                self.arrOpenTime[indexPath.row] = time
            }
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: true, completion: nil)
        }
        
        cell.cloCloseTime = {() in
            let vc = R.storyboard.main().instantiateViewController(withIdentifier: "ResChooseTimeVC") as! ResChooseTimeVC
            vc.cloSelect = {(time) in
                cell.btnCloseTime.setTitle(time, for: .normal)
                self.arrCloseTime[indexPath.row] = time
            }
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: true, completion: nil)
        }
        return cell
    }
}
