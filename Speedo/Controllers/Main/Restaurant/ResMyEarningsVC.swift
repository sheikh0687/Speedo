//
//  MyEarningsVC.swift
//  Speedo
//
//  Created by mac on 21/04/21.
//

import UIKit

class ResMyEarningsVC: UIViewController {

    @IBOutlet weak var tableViewOt: UITableView!
    @IBOutlet weak var lblEarning: UILabel!
    @IBOutlet weak var lblToday: UILabel!
    @IBOutlet weak var lblWeek: UILabel!
    @IBOutlet weak var lblMonth: UILabel!
    @IBOutlet weak var lblYear: UILabel!
    
    var identifier = "MyEarningCell"
    var arr:[ResMyEarning] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBarItem(LeftTitle: "", LeftImage: "menu", CenterTitle: R.string.localizable.myEarnings(), CenterImage: "", RightTitle: "", RightImage: "", BackgroundColor: k.themeColor, BackgroundImage: "", TextColor: "#FFFFFF", TintColor: "#FFFFFF", Menu: "")
//        self.tableViewOt.register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
        if let userType = k.userDefault.value(forKey: k.session.userType) as? String, userType == "RESTAURANT" {
            self.getRequest()
        } else {
            self.getMyEarning()
        }
    }
    
    override func leftClick() {
        toggleLeft()
    }
    
    func paramRequest() -> [String:AnyObject] {
        var dict : [String:AnyObject] = [:]
        dict["company_id"] = k.userDefault.value(forKey: k.session.userId)! as AnyObject
        return dict
    }
    
    func getRequest() {
        Api.shared.getRestEarnings(self, self.paramRequest()) { (response) in
            self.lblEarning.text = "\(k.currency) \(response.restTotalEarning ?? "")"
            self.lblToday.text = "\(k.currency) \(response.total_earning_today ?? "")"
            self.lblWeek.text = "\(k.currency) \(response.total_earning_weekly ?? "")"
            self.lblMonth.text = "\(k.currency) \(response.total_earning_monthly ?? "")"
            self.lblYear.text = "\(k.currency) \(response.total_earning_yearly ?? "")"
        }
    }
    
    func getMyEarning() {
        Api.shared.getDriverEarnings(self) { (response) in
            self.lblEarning.text = "\(k.currency) \(response.driver_total_earning ?? "")"
            self.lblToday.text = "\(k.currency) \(response.driver_total_earning_today ?? "")"
            self.lblWeek.text = "\(k.currency) \(response.driver_total_earning_week ?? "")"
            self.lblMonth.text = "\(k.currency) \(response.driver_total_earning_month ?? "")"
            self.lblYear.text = "\(k.currency) \(response.driver_total_earning_year ?? "")"
        }
    }
}

//extension ResMyEarningsVC: UITableViewDataSource {
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return self.arr.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.myEarningCell, for: indexPath)!
//        let obj = self.arr[indexPath.row]
//
//        let arrItems = obj.productDetails?.map({ "\($0.quantity ?? "") x \($0.itemName ?? "")" }).joined(separator: ",")
//        cell.lblItems.text = arrItems
//
//        cell.lblTotal.text = "\(obj.driverDelFee ?? "") \(k.currency)"
//        cell.lblOrderDate.text = obj.date ?? ""
//        cell.lblPickupAddress.text = obj.restDetails?.address ?? ""
//        cell.lblDeliveryAddress.text = obj.addressDetails?.address ?? ""
//        cell.lblDrivenKm.text = "\(obj.delKm ?? "") km"
//        cell.lblDeliveryFee.text = "\(obj.driverDelFee ?? "") \(k.currency)"
//        return cell
//    }
//}
