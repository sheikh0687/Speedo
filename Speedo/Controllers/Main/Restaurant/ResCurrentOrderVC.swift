//
//  DrvCurrentOrderVC.swift
//  Speedo
//
//  Created by mac on 21/04/21.
//

import UIKit

class ResCurrentOrderVC: UIViewController {
   
    @IBOutlet weak var tableViewOt: UITableView!
    
    var identifier = "ResOpenOrderCell"
    var arr:[ResRestOrder] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableViewOt.register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.getRequest()
    }
    
    func paramRequest() -> [String:AnyObject] {
        var dict : [String:AnyObject] = [:]
        dict["company_id"] = k.userDefault.value(forKey: k.session.userId)! as AnyObject
        dict["type"] = "CURRENT" as AnyObject
        return dict
    }
    
    func getRequest() {
        Api.shared.getRestOrders(self, self.paramRequest()) { (response) in
            if response.count > 0 {
                self.arr = response
            } else {
                self.arr = []
            }
            self.tableViewOt.reloadData()
        }
    }
    
    func paramChangeStatus(_ orderId: String, _ status: String, _ selTime: String) -> [String:AnyObject] {
        var dict : [String:AnyObject] = [:]
        dict["status"] = status as AnyObject
        dict["order_request_id"] = orderId as AnyObject
        dict["order_ready_time"] = selTime as AnyObject
        return dict
    }
    
    func changeStatus(_ orderId: String, _ status: String, _ selTime: String) {
        Api.shared.restChangeStatus(self, self.paramChangeStatus(orderId, status, selTime)) { (response) in
            self.getRequest()
        }
    }
}

extension ResCurrentOrderVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.resOpenOrderCell, for: indexPath)!
        cell.vwStatusButton.isHidden = true
        
        let obj = self.arr[indexPath.row]
        if let arrCart = obj.cartDetails {
            cell.bindItems(arr: arrCart)
        }
        cell.lblOrderId.text = "\(R.string.localizable.orderId()) \(obj.id ?? "")"
        cell.lblTotal.text = "\(k.currency) \(obj.totalAmount ?? "")"
        
        if obj.date != "" && obj.time != "" {
            cell.lblDateTime.text = "\(obj.time ?? "") \(obj.date ?? "")"
        }else{
            cell.lblDateTime.text = obj.dateTime ?? ""
        }
        
//        let arrItems = obj.productDetails?.map({ "\($0.quantity ?? "") x \($0.itemName ?? "")" }).joined(separator: ",")
//        cell.lblItems.text = arrItems
        
        cell.lblUserName.text = "\(obj.userDetails?.firstName ?? "") \(obj.userDetails?.lastName ?? "")"
        cell.lblUserAddress.text = obj.addressDetails?.address ?? ""
        Utility.setImageWithSDWebImage(obj.userDetails?.image ?? "", cell.imgUser)
        
        cell.lblDriverName.text = "\(obj.driverDetails?.firstName ?? "") \(obj.driverDetails?.lastName ?? "")"
        Utility.setImageWithSDWebImage(obj.driverDetails?.image ?? "", cell.imgDriver)
        
        print(obj.deliveryType)
        if let deliveryTyp = obj.deliveryType, deliveryTyp == "Pickup" {
            cell.btnAssignedDriver.isHidden = true
        }
        
        let status = obj.status ?? ""
        switch status {
        case "Pending":
            cell.lblOrderStatus.text = R.string.localizable.pending()
        case "Accept":
            cell.lblOrderStatus.text = R.string.localizable.preparing()
        case "Preparing":
            cell.lblOrderStatus.text = R.string.localizable.ready()
        case "Ready":
            if let deliveryType = obj.deliveryType, deliveryType == "Pickup" {
                cell.btnNotifyReady.setTitle(R.string.localizable.clickToDeliver(), for: .normal)
            } else {
                cell.btnNotifyReady.setTitle(R.string.localizable.trackOrder(), for: .normal)
                cell.lblOrderStatus.text = R.string.localizable.ready()
                cell.btnNotifyReady.backgroundColor = .white
                cell.btnNotifyReady.setTitleColor(R.color.theme_color(), for: .normal)
            }
        case "Reject":
            cell.lblOrderStatus.text = R.string.localizable.rejected()
        default:
            cell.lblOrderStatus.text = R.string.localizable.pending()
        }
        
        if let deliveryType = obj.deliveryType, deliveryType == "Pickup" {
            cell.btnAssignedDriver.isHidden = true
            cell.vwDriverDetail.isHidden = true
        } else {
            if let acceptDriverId = obj.acceptDriverId, acceptDriverId != "" {
                cell.btnAssignedDriver.isHidden = true
                cell.vwDriverDetail.isHidden = false
            } else {
                cell.btnAssignedDriver.isHidden = false
                cell.vwDriverDetail.isHidden = true
            }
        }
        
        cell.cloNotifyReady = {() in
            if let status = obj.status, status == "Ready" {
                if let deliveryType = obj.deliveryType, deliveryType == "Pickup" {
                    self.changeStatus(obj.id ?? "", "Complete", "")
                } else {
                    let vc = R.storyboard.main().instantiateViewController(withIdentifier: "RestOrderDetailVC") as! RestOrderDetailVC
                    vc.orderId = obj.id ?? ""
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            } else if status == "Accept" {
                self.changeStatus(obj.id ?? "", "Ready", "")
            } else {
                let vc = R.storyboard.main().instantiateViewController(withIdentifier: "RestOrderDetailVC") as! RestOrderDetailVC
                vc.orderId = obj.id ?? ""
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        
        cell.cloPrint = {() in
            let vc = R.storyboard.main().instantiateViewController(withIdentifier: "ResPrintVC") as! ResPrintVC
            vc.orderId = self.arr[indexPath.row].id ?? ""
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        cell.cloAssignedDriver = {() in
            let vc = R.storyboard.main().instantiateViewController(withIdentifier: "RestAvailableDriverVC") as! RestAvailableDriverVC
            vc.orderId = self.arr[indexPath.row].id ?? ""
            vc.cloRefresh = {() in
                self.getRequest()
            }
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        cell.cloCallDriver = {() in
            Utility.callNumber(phoneNumber: obj.driverDetails?.mobile ?? "")
        }
        return cell
    }
}
