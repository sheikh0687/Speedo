//
//  DrvHomeVC.swift
//  Speedo
//
//  Created by mac on 21/04/21.
//

import UIKit

class DrvHomeVC: UIViewController {
    
    @IBOutlet weak var tableViewOt: UITableView!
    @IBOutlet weak var btnOnlineStatus: UISwitch!
    
    var identifier = "DrvOrderCell"
    var arr:[ResDrvNewRequest] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableViewOt.register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBarItem(LeftTitle: "", LeftImage: "menu", CenterTitle: R.string.localizable.home(), CenterImage: "", RightTitle: "", RightImage: "", BackgroundColor: k.themeColor, BackgroundImage: "", TextColor: "#FFFFFF", TintColor: "#FFFFFF", Menu: "")
        self.getNewRequest()
    }
    
    override func leftClick() {
        toggleLeft()
    }
    
    func getNewRequest() {
        Api.shared.drvGetNewRequest(self) { (response) in
            if response.count > 0 {
                self.arr = response
            } else {
                self.arr = []
            }
            self.tableViewOt.reloadData()
        }
    }
    
    func paramAcceptReject(_ orderId: String, _ status: String) -> [String:AnyObject] {
        var dict : [String:AnyObject] = [:]
        dict["driver_id"] = k.userDefault.value(forKey: k.session.userId)! as AnyObject
        dict["delivery_status"] = status as AnyObject
        dict["order_request_id"] = orderId as AnyObject
        return dict
    }
    
    func acceptReject(_ orderId: String, _ status: String) {
        print(self.paramAcceptReject(orderId, status))
        Api.shared.drvAccept(self, self.paramAcceptReject(orderId, status)) { (response) in
            self.getNewRequest()
        }
    }
    
    @IBAction func btnOnline(_ sender: UISwitch) {
        if sender.isOn {
            self.onlineStatus("ONLINE")
        } else {
            self.onlineStatus("OFFLINE")
        }
    }
    
    func paramOnlineStatus(_ onlineStatus: String) -> [String:AnyObject] {
        var dict : [String:AnyObject] = [:]
        dict["driver_id"] = k.userDefault.value(forKey: k.session.userId)! as AnyObject
        dict["available_status"] = onlineStatus as AnyObject
        return dict
    }
    
    func onlineStatus(_ onlineStatus: String) {
        Api.shared.updateOnlineStatus(self, self.paramOnlineStatus(onlineStatus)) { (response) in
            if let status = response.availableStatus, status == "ONLINE" {
                self.btnOnlineStatus.isOn = true
            } else {
                self.btnOnlineStatus.isOn = false
            }
        }
    }
}

extension DrvHomeVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.drvOrderCell, for: indexPath)!
        cell.vwNotifyUser.isHidden = true
        cell.btnSeeOnMap.isHidden = true
        cell.vwOrderDetail.isHidden = true
        cell.lblRestTotalAmount.isHidden = true
        
        let obj = self.arr[indexPath.row]
        let objRest = obj.restDetails
        cell.lblRest.text = objRest?.restName ?? ""
        Utility.setImageWithSDWebImage(objRest?.restImage ?? "", cell.imgRest)
        cell.lblRestRating.text = "NA"
        cell.lblAddress.text = objRest?.address ?? ""
        
        cell.lblTotalAmount.text = "\(k.currency) \(obj.totalAmount ?? "")"
        cell.lblOrderId.text = "\(R.string.localizable.orderId()) \(obj.id ?? "")"
        cell.lblOrderDate.text = obj.dateTime ?? ""
        
//        let arrItems = obj.productDetails?.map({ "\($0.quantity ?? "") x \($0.itemName ?? "")" }).joined(separator: ",")
//        cell.lblItems.text = arrItems
        
        print(obj.cartDetails?.count)
        if let arrCart = obj.cartDetails {
            print(arrCart[0].productName ?? "")
            cell.bindItems(arr: arrCart)
        }
        
        cell.lblUserName.text = obj.userDetails?.firstName ?? ""
        cell.lblUserAddress.text = obj.addressDetails?.address ?? ""
        Utility.setImageWithSDWebImage(obj.userDetails?.image ?? "", cell.imgUser)
        
        cell.cloAccept = {() in
            self.acceptReject(obj.id ?? "", "Accept")
        }
        
        cell.cloReject = {() in
            self.acceptReject(obj.id ?? "", "Reject")
        }
        return cell
    }
}

extension DrvHomeVC: UITableViewDelegate {
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 350
//    }
}
