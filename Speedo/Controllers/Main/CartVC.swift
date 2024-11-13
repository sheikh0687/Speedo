//
//  CartVC.swift
//  Speedo
//
//  Created by mac on 20/04/21.
//

import UIKit

class CartVC: UIViewController {

    @IBOutlet weak var tableViewOt: UITableView!
    @IBOutlet var btnSubmit: UIButton!
    @IBOutlet var lblTotal: UILabel!
    @IBOutlet weak var lblDiscount: UILabel!
    @IBOutlet weak var lblGrandTotal: UILabel!
    @IBOutlet weak var vwCalc: UIView!
    
    var identifier = "CartsCell"
    var arrCart:[ResCart] = []
    var companyId = ""
    var StrForgotEmail:String = ""
    var cartId = ""
    var catId = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableViewOt.register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBarItem(LeftTitle: "", LeftImage: "back", CenterTitle: R.string.localizable.myCart(), CenterImage: "", RightTitle: "", RightImage: "", BackgroundColor: k.themeColor, BackgroundImage: "", TextColor: "#FFFFFF", TintColor: "#FFFFFF", Menu: "")
        self.tabBarController?.tabBar.isHidden = true
        self.getCart()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    func getCart() {
        Api.shared.getCart(self) { (response) in
            self.lblTotal.text = "\(k.currency) \(response.totalAmount ?? "")"
            self.lblGrandTotal.text = "\(k.currency) \(response.totalAmount ?? "")"
            if response.result?.count ?? 0 > 0 {
                self.arrCart = response.result ?? []
                self.companyId = response.result?[0].companyId ?? ""
                self.cartId = response.result?[0].id ?? ""
                self.catId = response.result?[0].catId ?? ""
                self.vwCalc.isHidden = false
            } else {
                self.arrCart = []
                self.cartId = ""
                self.catId = ""
                self.vwCalc.isHidden = true
            }
            self.tableViewOt.reloadData()
        }
    }
    
    func paramUpdateCart(_ cartId: String, _ amount: Int, _ qty: Int, _ type: String) -> [String:AnyObject] {
        var dict : [String:AnyObject] = [:]
        dict["cart_id"] = cartId as AnyObject
        dict["total_amount"] = amount as AnyObject
        dict["quantity"] = qty as AnyObject
        dict["type"] = type as AnyObject
        return dict
    }
    
    func updateCart(_ cartId: String, _ amount: Int, _ qty: Int, _ type: String) {
        Api.shared.updateCart(self, self.paramUpdateCart(cartId, amount, qty, type)) { (response) in
            Utility.showAlertWithAction(withTitle: k.appName, message: R.string.localizable.cartUpdatedSuccessfully(), delegate: nil, parentViewController: self) { (boool) in
                self.getCart()
            }
        }
    }
    
    func paramDelete(_ cartId: String) -> [String:AnyObject] {
        var dict : [String:AnyObject] = [:]
        dict["cart_id"] = cartId as AnyObject
        return dict
    }
    
    func delete(_ cartId: String) {
        Api.shared.deleteCart(self, self.paramDelete(cartId)) { (response) in
            Utility.showAlertWithAction(withTitle: k.appName, message: R.string.localizable.cartDeletedSuccessfully(), delegate: nil, parentViewController: self) { (boool) in
                self.getCart()
            }
        }
    }
    
    @IBAction func btnSubmit(_ sender: UIButton) {
        let vc = R.storyboard.main().instantiateViewController(withIdentifier: "PlaceOrderVC") as! PlaceOrderVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func applyCode(_ id: String, _ catIdd: String) {
        //Create the AlertController
        let actionSheetController: UIAlertController = UIAlertController(title: "", message: R.string.localizable.applyOffer(), preferredStyle: .alert)
        
        //Create and add the Cancel action
        let cancelAction: UIAlertAction = UIAlertAction(title: R.string.localizable.cancel(), style: .cancel) { action -> Void in
            //Do some stuff
            
        }
        actionSheetController.addAction(cancelAction)
        //Create and an option action
        let nextAction: UIAlertAction = UIAlertAction(title: R.string.localizable.oK(), style: .default) { action -> Void in
            //Do some other stuff
            let fields = actionSheetController.textFields!;
            print("Yes we can: "+fields[0].text!);
            self.StrForgotEmail = fields[0].text!
            self.applyOfferCode(id, catIdd)
        }
        actionSheetController.addAction(nextAction)
        //Add a text field
        actionSheetController.addTextField { textField -> Void in
            //TextField configuration
            textField.textColor = UIColor.black
            textField.placeholder = R.string.localizable.enterOfferCode()
        }
        //Present the AlertController
        self.present(actionSheetController, animated: true, completion:  nil)
    }
    
    func applyOfferCode(_ cartId: String, _ catId: String) {
        print(self.paramApplyOfferCode(cartId, catId))
        Api.shared.applyOffer(self, self.paramApplyOfferCode(cartId, catId)) {(response) in
            self.getCart()
        }
    }
    
    func paramApplyOfferCode(_ cartId: String, _ catId: String) -> [String:AnyObject] {
        var dict : [String:AnyObject] = [:]
        dict["user_id"] = k.userDefault.value(forKey: k.session.userId)! as AnyObject
        dict["current_time"] = Utility.getCurrentTime() as AnyObject
        dict["rest_id"] = k.userDefault.value(forKey: k.session.interestedRestId)!  as AnyObject
        dict["offer_code"] = self.StrForgotEmail as AnyObject
        dict["cart_id"] = cartId as AnyObject
        dict["cat_id"] = catId as AnyObject
        return dict
    }
}

extension CartVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrCart.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.cartsCell, for: indexPath)!
        let obj = self.arrCart[indexPath.row]
        cell.configureCell(data: self.arrCart[indexPath.row])
        cell.cloPlus = { () in
            let qty = (Int(obj.quantity ?? "") ?? 0) + 1
            let amount = (Int(obj.productDetails?.itemPrice ?? "") ?? 0) * qty
            self.updateCart(obj.id ?? "", amount, qty, "Plus")
        }
        cell.cloMinus = { () in
            let qty = (Int(obj.quantity ?? "") ?? 0) - 1
            if qty > 0 {
                let amount = (Int(obj.productDetails?.itemPrice ?? "") ?? 0) * qty
                self.updateCart(obj.id ?? "", amount, qty, "Minus")
            }
        }
        cell.cloDelete = { () in
            self.delete(self.arrCart[indexPath.row].id ?? "")
        }
        
        cell.cloApplyCode = {() in
            self.applyCode(obj.id ?? "", obj.catId ?? "")
        }
        return cell
    }
}

extension CartVC: UITableViewDelegate {
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 150
//    }
}

extension CartVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arrCart.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.cartCell, for: indexPath)!
        let obj = self.arrCart[indexPath.row]
        cell.configureCell(data: self.arrCart[indexPath.row])
        cell.cloPlus = { () in
            let qty = (Int(obj.quantity ?? "") ?? 0) + 1
            let amount = (Int(obj.productDetails?.itemPrice ?? "") ?? 0) * qty
            self.updateCart(obj.id ?? "", amount, qty, "Plus")
        }
        cell.cloMinus = { () in
            let qty = (Int(obj.quantity ?? "") ?? 0) - 1
            if qty > 0 {
                let amount = (Int(obj.productDetails?.itemPrice ?? "") ?? 0) * qty
                self.updateCart(obj.id ?? "", amount, qty, "Minus")
            }
        }
        cell.cloDelete = { () in
            self.delete(self.arrCart[indexPath.row].id ?? "")
        }
        return cell
    }
}

extension CartVC: UICollectionViewDelegateFlowLayout {
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: (self.collectionViewProductOt.frame.width), height: 115.0)
//    }
}
