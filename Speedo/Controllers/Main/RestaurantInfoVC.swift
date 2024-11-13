//
//  RestaurantInfoVC.swift
//  Speedo
//
//  Created by mac on 30/11/21.
//

import UIKit
import Cosmos

class RestaurantInfoVC: UIViewController {

    @IBOutlet weak var lblTotalCart: UILabel!
    @IBOutlet weak var lblTotalCount: UILabel!
    @IBOutlet weak var vwCart: UIView!
    @IBOutlet weak var tableViewOt: UITableView!
    @IBOutlet weak var constraintTableHeight: NSLayoutConstraint!
    @IBOutlet weak var lblRestName: UILabel!
    @IBOutlet weak var imgRest: UIImageView!
    @IBOutlet weak var imgDish: UIImageView!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var lblSpeciality: UILabel!
    @IBOutlet weak var vwRating: CosmosView!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var lblPhoneNumber: UILabel!
    @IBOutlet weak var lblTaxNumber: UILabel!
    
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
        setNavigationBarItem(LeftTitle: "", LeftImage: "menu", CenterTitle: R.string.localizable.restaurantInformation(), CenterImage: "", RightTitle: "", RightImage: "", BackgroundColor: k.themeColor, BackgroundImage: "", TextColor: "#FFFFFF", TintColor: "#FFFFFF", Menu: "")
        self.getRestProfile()
        self.getCart()
    }
    
    override func leftClick() {
        toggleLeft()
    }
    
    func getRestProfile() {
        print(self.paramRestProfile())
        Api.shared.restGetProfile(self, self.paramRestProfile()) { (response) in
            if response.restDayDetails?.count ?? 0 > 0 {
                self.arr = response.restDayDetails ?? []
                self.constraintTableHeight.constant = CGFloat((self.arr.count * 40))
            } else {
                self.arr = []
                self.constraintTableHeight.constant = 0
            }
            self.lblRestName.text = response.restName ?? ""
            if let restImage = response.restImage, restImage != "" {
                let resImg = Router.BASE_IMAGE_URL + restImage
                Utility.setImageWithSDWebImage(resImg, self.imgDish)
            }
            if let restCoverImage = response.restCoverImage, restCoverImage != "" {
                let restCoverImg = Router.BASE_IMAGE_URL + restCoverImage
                Utility.setImageWithSDWebImage(restCoverImg, self.imgRest)
            }
             let restOpenCloseStatus = response.restOpenStatus
             print(restOpenCloseStatus)
                if restOpenCloseStatus == "CLOSE" {
                self.lblStatus.text = "CLOSE"
            } else {
                self.lblStatus.text = "OPEN"
            }
            if let status = response.restOpenStatus, status == "CLOSE" {
                self.lblStatus.backgroundColor = .red
            }
            self.vwRating.rating = Double(response.avgRating ?? "") ?? 0.0
            self.vwRating.text = "(\(response.totalRatingCount ?? ""))"
            
            self.lblLocation.text = response.address ?? ""
            self.lblPhoneNumber.text = "\(R.string.localizable.phoneNumber()) \(response.mobile ?? "")"
            self.lblTaxNumber.text = "\(R.string.localizable.taxNumber()) \(response.taxNumber ?? "")"
            
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
        dict["rest_id"] = k.userDefault.value(forKey: k.session.interestedRestId) as AnyObject
        dict["user_id"] = k.userDefault.value(forKey: k.session.userId) as AnyObject
        dict["timezone"] = localTimeZoneIdentifier as AnyObject
        dict["now_current_day"] = Utility.getCurrentDay() as AnyObject
        return dict
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
    
    @IBAction func btnCart(_ sender: UIButton) {
    }
}

extension RestaurantInfoVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.restUpdProfileCell, for: indexPath)!
        let obj = self.arr[indexPath.row]
        cell.btnStatus.isHidden = true
        cell.lblDay.text = obj.openDay ?? ""
        cell.btnOpenTime.setTitle(obj.openTime ?? "", for: .normal)
        cell.btnCloseTime.setTitle(obj.closeTime ?? "", for: .normal)
        cell.btnStatus.setTitle(obj.restOpeClossStatus ?? "", for: .normal)
        
        if let status = obj.restOpeClossStatus, status == "OPEN" {
            cell.btnStatus.backgroundColor = R.color.theme_color()
        } else {
            cell.btnStatus.backgroundColor = .lightGray
        }
      
        return cell
    }
}

extension RestaurantInfoVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40.0
    }
}
