//
//  CurrentOrderVC.swift
//  Speedo
//
//  Created by mac on 18/04/21.
//

import UIKit

class CurrentOrderVC: UIViewController {

    @IBOutlet weak var tableViewOt: UITableView!
    
    var identifier = "OrderCell"
    var arr:[ResOrders] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableViewOt.register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if Utility.isUserLogin() {
            self.getOrders()
        }
    }
    
    func paramGetOrders() -> [String:AnyObject] {
        var dict : [String:AnyObject] = [:]
        dict["user_id"] = k.userDefault.value(forKey: k.session.userId) as AnyObject
        dict["type"] = "CURRENT" as AnyObject
        print(dict)
        return dict
    }
    
    func getOrders() {
        Api.shared.getPendingOrders(self, self.paramGetOrders()) { (response) in
            if response.count > 0 {
                self.arr = response
            } else {
                self.arr = []
            }
            self.tableViewOt.reloadData()
        }
    }
}

extension CurrentOrderVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.orderCell, for: indexPath)!
        let object = self.arr[indexPath.row]
        
        cell.lblItemName.text = object.restDetails?.restName ?? ""
        cell.lblDesc.text = object.restDetails?.address ?? ""
        cell.lblPrice.text = "\(k.currency)\(object.totalAmount ?? "")"
        cell.lblOrderStatus.text = object.status ?? ""
        cell.lblTotalAmount.text = "\(object.totalAmount ?? "") \(k.currency)"
//        cell.lblExtraItem.text = object.cartDetails?.map({$0.extraItemName ?? ""}).joined(separator: ",")
        cell.lblSubtotal.text = "\(object.sub_total ?? "") \(k.currency)"
        cell.lblDeliveryFee.text = "\(object.delivery_fee ?? "").00 \(k.currency)"
        cell.lblDiscount.text = "\(object.discount_amt ?? "") \(k.currency)"
        if object.status ?? "" != "Pending" {
            cell.lblOrderStatus.backgroundColor = hexStringToUIColor(hex: "DA4B13")
        }else{
            cell.lblOrderStatus.backgroundColor = .lightGray
        }
        Utility.setImageWithSDWebImage(object.restDetails?.restImage ?? "", cell.imgItem)
        
        if let orderType = object.orderType, orderType == "Current" {
            cell.lblOrderId.text = "\(R.string.localizable.orderId()) \(object.id ?? "")"
        } else {
            cell.lblOrderId.text = "\(R.string.localizable.preOrderID()) \(object.id ?? "")"
        }
        
//        let arrItems = object.productDetails?.map({ "\($0.quantity ?? "") x \($0.itemName ?? "")" }).joined(separator: ",")
//        cell.lblItems.text = arrItems
        
//        if let productDetails = object.productDetails, let cartDetails = object.cartDetails {
//            let itemStrings = productDetails.map { product in
//                let itemName = product.itemName ?? ""
//                let quantity = product.quantity ?? ""
//                let cartSizes = cartDetails.map { $0.sizeName ?? "" }
//                print("Item Name: \(itemName), Quantity: \(quantity), Cart Sizes: \(cartSizes)")
//                return "\(quantity) x \(itemName) (\(cartSizes.joined(separator: ","))"
//            }
//            let arrItems = itemStrings.joined(separator: ",")
//            cell.lblItems.text = arrItems
//        } else {
//            // Handle the case when either of them is nil or both are nil
//        }
        
        if object.date != "" && object.time != "" {
            cell.lblOrderDate.text = "\(object.time ?? "") \(object.date ?? "")"
        }else{
            cell.lblOrderDate.text = object.dateTime ?? ""
        }
        cell.btnReorder.isHidden = true
        
        cell.cloTrackOrder = {() in
            let vc = R.storyboard.main().instantiateViewController(withIdentifier: "DrvOrderDetailVC") as! DrvOrderDetailVC
            vc.orderId = object.id ?? ""
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        cell.cloPrint = {() in
            let vc = R.storyboard.main().instantiateViewController(withIdentifier: "ResPrintVC") as! ResPrintVC
            vc.orderId = self.arr[indexPath.row].id ?? ""
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        if let delivery_type = object.delivery_type, delivery_type == "Pickup" {
            cell.btnTrackOrder.isHidden = true
        } else {
            cell.btnTrackOrder.isHidden = false
        }
        
        if let arrCart = object.cartDetails {
            cell.bindItems(arr: arrCart)
        }
        
        return cell
    }
}
