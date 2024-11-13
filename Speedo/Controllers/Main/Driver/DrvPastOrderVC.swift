//
//  DrvPastOrderVC.swift
//  Speedo
//
//  Created by mac on 21/04/21.
//

import UIKit

class DrvPastOrderVC: UIViewController {
    
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
        dict["type"] = "PAST" as AnyObject
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
}

extension DrvPastOrderVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.drvOrderCell, for: indexPath)!
        cell.vwUserDetail.isHidden = true
        cell.vwNotifyUser.isHidden = true
        cell.btnSeeOnMap.isHidden = true
        cell.vwButtonStatus.isHidden = true
        cell.lblTotalAmount.isHidden = true
        cell.vwRatingStatus.isHidden = true
        cell.constraintHeightRatingStatus.constant = 0
        cell.lblRestTotalAmount.isHidden = true
       
        cell.vwDelivered.isHidden = false
        let obj = self.arr[indexPath.row]
        let objRest = obj.restDetails
        cell.lblRest.text = objRest?.restName ?? ""
        Utility.setImageWithSDWebImage(objRest?.restImage ?? "", cell.imgRest)
        cell.lblRestRating.text = "NA"
        cell.lblAddress.text = objRest?.address ?? ""
        
        cell.lblRestTotalAmount.text = "\(k.currency) \(obj.totalAmount ?? "")"
        
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
        
        cell.lblUserName.text = obj.userDetails?.firstName ?? ""
        cell.lblUserAddress.text = obj.addressDetails?.address ?? ""
        Utility.setImageWithSDWebImage(obj.userDetails?.image ?? "", cell.imgUser)
        
        cell.cloAccept = {() in
            
        }
        
        cell.cloReject = {() in
            
        }
        
        cell.cloPrintBill = {() in
            let vc = R.storyboard.main().instantiateViewController(withIdentifier: "ResPrintVC") as! ResPrintVC
            vc.orderId = self.arr[indexPath.row].id ?? ""
            self.navigationController?.pushViewController(vc, animated: true)
        }
        return cell
    }
}

extension DrvPastOrderVC: UITableViewDelegate {
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 240
//    }
}
