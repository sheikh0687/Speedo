//
//  DrvOpenOrderVC.swift
//  Speedo
//
//  Created by mac on 21/04/21.
//

import UIKit

class ResOpenOrderVC: UIViewController {

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
        dict["type"] = "PENDING" as AnyObject
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
        dict["cancel_reason"] = k.emptyString as AnyObject
        print(dict)
        return dict
    }
    
    func changeStatus(_ orderId: String, _ status: String, _ selTime: String) {
        Api.shared.restChangeStatus(self, self.paramChangeStatus(orderId, status, selTime)) { (response) in
            self.getRequest()
        }
    }
    
    func paramReject(_ orderId: String, _ status: String, _ reason : String) -> [String:AnyObject] {
        var dict : [String:AnyObject] = [:]
        dict["status"] = status as AnyObject
        dict["order_request_id"] = orderId as AnyObject
        dict["order_ready_time"] = k.emptyString as AnyObject
        dict["cancel_reason"] = reason as AnyObject
        return dict
    }
    
    func rejectStatus(_ orderId: String, _ status: String, _ selTime: String) {
        Api.shared.restChangeStatus(self, self.paramChangeStatus(orderId, status, selTime)) { (response) in
            self.getRequest()
        }
    }
}

extension ResOpenOrderVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.resOpenOrderCell, for: indexPath)!
        cell.vwStatus.isHidden = true
        cell.vwDriverDetail.isHidden = true
        
        let obj = self.arr[indexPath.row]
        print(obj.cartDetails?.count)
        if let arrCart = obj.cartDetails {
            print(arrCart[0].productName ?? "")
            cell.bindItems(arr: arrCart)
        }
        cell.lblOrderId.text = "\(R.string.localizable.orderId()) \(obj.id ?? "")"
        cell.lblDateTime.text = obj.dateTime ?? ""
        
//        let arrItems = obj.productDetails?.map({ "\($0.quantity ?? "") x \($0.itemName ?? "")" }).joined(separator: ",")
//        cell.lblItems.text = arrItems
        
        cell.lblUserName.text = "\(obj.userDetails?.firstName ?? "") \(obj.userDetails?.lastName ?? "")"
        cell.lblUserAddress.text = obj.addressDetails?.address ?? ""
        Utility.setImageWithSDWebImage(obj.userDetails?.image ?? "", cell.imgUser)
        
        cell.lblSubtotal.text = "\(obj.subTotal ?? "") \(k.currency)"
        cell.lblDiscount.text = "\(obj.discountAmt ?? "") \(k.currency)"
        cell.lblDeliveryFees.text = "\(obj.deliveryFee ?? "") \(k.currency)"
        cell.lblTotal.text = "\(obj.totalAmount ?? "") \(k.currency)"
        
        if let deliveryTyp = obj.deliveryType, deliveryTyp == "Pickup" {
            cell.btnAssignedDriver.isHidden = true
        }
        
        cell.cloTakeOrder = {() in
            if let status = obj.status, status == "Pending" {
                let vc = R.storyboard.main().instantiateViewController(withIdentifier: "ResTimeSelVC") as! ResTimeSelVC
                vc.modalTransitionStyle = .crossDissolve
                vc.modalPresentationStyle = .overFullScreen
                vc.cloSelectTime = {(selTime) in
                    self.changeStatus(obj.id ?? "", "Accept", selTime)
                }
                vc.cloAccept = {() in
                    self.changeStatus(obj.id ?? "", "Accept", "On Time")
                }
                self.present(vc, animated: true, completion: nil)
            } else {
                
            }
        }
        
        cell.cloItemNotAvailable = {() in
            self.rejectStatus(obj.id ?? "", "Reject", "Item is not available more")
        }
        
        cell.cloCancelOrder = {() in
            self.rejectStatus(obj.id ?? "", "Reject", "")
        }
        return cell
    }
}
