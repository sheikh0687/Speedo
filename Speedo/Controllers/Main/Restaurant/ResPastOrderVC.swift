//
//  DrvPastOrderVC.swift
//  Speedo
//
//  Created by mac on 21/04/21.
//

import UIKit

class ResPastOrderVC: UIViewController {
    
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
        dict["type"] = "PAST" as AnyObject
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
}

extension ResPastOrderVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.resOpenOrderCell, for: indexPath)!
//        cell.vwStatus.isHidden = true
        cell.lblOrderStatus.isHidden = true
        cell.vwStatusButton.isHidden = true
        cell.vwDriverDetail.isHidden = true
        cell.vwAssignedDriver.isHidden = true
        
        let obj = self.arr[indexPath.row]
        if let arrCart = obj.cartDetails {
            cell.bindItems(arr: arrCart)
        }
        
     
        cell.lblOrderId.text = "\( R.string.localizable.orderId()) \(obj.id ?? "")"
     
        if obj.date != "" && obj.time != "" {
            cell.lblDateTime.text = "\(obj.time ?? "") \(obj.date ?? "")"
        }else{
            cell.lblDateTime.text = obj.dateTime ?? ""
        }
        
        
        cell.lblSubtotal.text = "\(obj.subTotal ?? "") \(k.currency)"
        cell.lblDiscount.text = "\(obj.discountAmt ?? "") \(k.currency)"
        cell.lblDeliveryFees.text = "\(obj.deliveryFee ?? "") \(k.currency)"
        cell.lblTotal.text = "\(obj.totalAmount ?? "") \(k.currency)"
        
//        let arrItems = obj.productDetails?.map({ "\($0.quantity ?? "") x \($0.itemName ?? "")" }).joined(separator: ",")
//        cell.lblItems.text = arrItems
        
        cell.lblUserName.text = "\(obj.userDetails?.firstName ?? "") \(obj.userDetails?.lastName ?? "")"
        cell.lblUserAddress.text = obj.addressDetails?.address ?? ""
        Utility.setImageWithSDWebImage(obj.userDetails?.image ?? "", cell.imgUser)
        
        cell.cloPrint = {() in
            let vc = R.storyboard.main().instantiateViewController(withIdentifier: "ResPrintVC") as! ResPrintVC
            vc.orderId = self.arr[indexPath.row].id ?? ""
            self.navigationController?.pushViewController(vc, animated: true)
        }
        return cell
    }
}
