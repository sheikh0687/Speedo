//
//  DrvCurrentOrderVC.swift
//  Speedo
//
//  Created by mac on 21/04/21.
//

import UIKit

class DrvCurrentOrderVC: UIViewController {
    
    @IBOutlet weak var tableViewOt: UITableView!
    
    var identifier = "DrvOrderCell"
    var arr:[ResDrvNewRequest] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableViewOt.register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.getNewRequest()
    }
    
    func paramRequest() -> [String:AnyObject] {
        var dict : [String:AnyObject] = [:]
        dict["driver_id"] = k.userDefault.value(forKey: k.session.userId)! as AnyObject
        dict["type"] = "CURRENT" as AnyObject
        return dict
    }
    
    func getNewRequest() {
        Api.shared.drvGetOrder(self, self.paramRequest()) { (response) in
            if response.count > 0 {
                self.arr = response
            } else {
                self.arr = []
            }
            self.tableViewOt.reloadData()
        }
    }
    
    func paramChangeDeliveryStatus(_ orderId: String, _ status: String) -> [String:AnyObject] {
        var dict : [String:AnyObject] = [:]
        dict["driver_id"] = k.userDefault.value(forKey: k.session.userId)! as AnyObject
        dict["delivery_status"] = status as AnyObject
        dict["order_request_id"] = orderId as AnyObject
        return dict
    }
    
    func changeDeliveryStatus(_ orderId: String, _ status: String) {
        Api.shared.drvDeliveryStatus(self, self.paramChangeDeliveryStatus(orderId, status)) { (response) in
            self.getNewRequest()
        }
    }
}

extension DrvCurrentOrderVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.drvOrderCell, for: indexPath)!
        cell.vwButtonStatus.isHidden = true
        cell.vwOrderDetail.isHidden = true
        cell.lblRestTotalAmount.isHidden = true
        cell.lblTotalAmount.isHidden = false
        
        let obj = self.arr[indexPath.row]
        let objRest = obj.restDetails
        cell.lblRest.text = objRest?.restName ?? ""
        Utility.setImageWithSDWebImage(objRest?.restImage ?? "", cell.imgRest)
        cell.lblRestRating.text = "NA"
        cell.lblAddress.text = objRest?.address ?? ""
        
        cell.lblTotalAmount.text = "\( R.string.localizable.yourFee()) \(obj.driverDelFee ?? "") \(k.currency)"
        cell.lblOrderId.text = "\(R.string.localizable.orderId()) \(obj.id ?? "")"
        if obj.date != "" && obj.time != "" {
            cell.lblOrderDate.text = "\(obj.time ?? "") \(obj.date ?? "")"
        }else{
            cell.lblOrderDate.text = obj.dateTime ?? ""
        }
        
//        let arrItems = obj.productDetails?.map({ "\($0.quantity ?? "") x \($0.itemName ?? "")" }).joined(separator: ",")
//        cell.lblItems.text = arrItems
        
        print(obj.cartDetails?.count)
        if let arrCart = obj.cartDetails {
            print(arrCart[0].productName ?? "")
            cell.bindItems(arr: arrCart)
        }
        
        cell.lblUserName.text = "\(obj.userDetails?.firstName ?? "") \(obj.userDetails?.lastName ?? "")"
        cell.lblUserAddress.text = obj.addressDetails?.address ?? ""
        Utility.setImageWithSDWebImage(obj.userDetails?.image ?? "", cell.imgUser)
        
        cell.cloSeeOnMap = {() in
            let vc = R.storyboard.main().instantiateViewController(withIdentifier: "DrvOrderDetailVC") as! DrvOrderDetailVC
            vc.orderId = obj.id ?? ""
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        let deliveryStatus = obj.deliveryStatus
        switch deliveryStatus {
        case "Accept":
            cell.btnDeliveryStatus.setTitle(R.string.localizable.notifyUserForOrderPicked(), for: .normal)
        case "Picked":
            cell.btnDeliveryStatus.setTitle(R.string.localizable.notifyUserToArrived(), for: .normal)
        case "Arrived":
            cell.btnDeliveryStatus.setTitle(R.string.localizable.clickToDeliver(), for: .normal)
        case "Delivered":
            cell.btnDeliveryStatus.setTitle(R.string.localizable.rateUserAndFinish(), for: .normal)
        default:
            print("")
        }
        
        cell.cloNotifyUserToArrive = {() in
            switch deliveryStatus {
            case "Accept":
                self.changeDeliveryStatus(obj.id ?? "", "Picked")
            case "Picked":
                self.changeDeliveryStatus(obj.id ?? "", "Arrived")
            case "Arrived":
                self.changeDeliveryStatus(obj.id ?? "", "Delivered")
            case "Delivered":
                let vc = R.storyboard.main().instantiateViewController(withIdentifier: "DrvRatingVC") as! DrvRatingVC
                vc.deliveryStatus = "Complete"
                vc.orderRequestId = obj.id ?? ""
                self.navigationController?.pushViewController(vc, animated: true)
            default:
                print("")
            }
        }
        return cell
    }
}

extension DrvCurrentOrderVC: UITableViewDelegate {
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 350
//    }
}
