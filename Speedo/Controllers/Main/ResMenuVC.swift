//
//  MenuVC.swift
//  Speedo
//
//  Created by mac on 19/04/21.
//

import UIKit

class ResMenuVC: UIViewController {

    @IBOutlet weak var btnLoadMore: UIButton!
    @IBOutlet weak var tableViewOt: UITableView!
    
    var identifier = "ProductMenuCell"
    var arrProducts:[ResProductsByCat] = []
    var restId = ""
    var size = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableViewOt.register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(restId)
        self.getProductByCategory()
    }
    
    func paramProductByCategory() -> [String:AnyObject] {
        var dict : [String:AnyObject] = [:]
        dict["user_id"] = k.userDefault.value(forKey: k.session.userId)! as AnyObject
        dict["rest_id"] = self.restId as AnyObject
        dict["size"] = self.size as AnyObject
        return dict
    }
    
    func getProductByCategory() {
        print(self.paramProductByCategory())
        Api.shared.getRestProductCustSide(self, self.paramProductByCategory()) { (response) in
            if response.count > 0 {
                self.arrProducts = response
                if response.count > 19 {
                    self.btnLoadMore.isHidden = false
                } else {
                    self.btnLoadMore.isHidden = true
                }
            } else {
                self.arrProducts = []
                self.btnLoadMore.isHidden = true
            }
            self.tableViewOt.reloadData()
        }
    }
    
    @IBAction func btnLoadMore(_ sender: UIButton) {
        self.size = self.size + 20
        self.getProductByCategory()
    }
    
    @objc func loadMore() {
        self.size = self.size + 20
        self.getProductByCategory()
    }
}

extension ResMenuVC: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrProducts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.productMenuCell, for: indexPath)!
        let obj = self.arrProducts[indexPath.row]
        cell.lblProductName.text = obj.itemName ?? ""
        cell.lblProductDesc.text = obj.descriptionField ?? ""
        cell.lblProductPrice.text = "\(k.currency) \(obj.itemPrice ?? "")"
        Utility.setImageWithSDWebImage(obj.image ?? "", cell.imgProduct)
        cell.cloAdd = {() in
            
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 150, height: 30))
        button.setTitle(R.string.localizable.loadMore(), for: .normal)
        button.addTarget(self, action: #selector(self.loadMore), for: .touchUpInside)
        return button
    }
}

extension ResMenuVC: UITableViewDelegate {
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 105
//    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = R.storyboard.main().instantiateViewController(withIdentifier: "ProductDetailVC") as! ProductDetailVC
        vc.productId = self.arrProducts[indexPath.row].id ?? ""
        vc.restId = self.restId
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
