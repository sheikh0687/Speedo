//
//  ProductVC.swift
//  Speedo
//
//  Created by mac on 19/04/21.
//

import UIKit

class ProductVC: UIViewController {
    
    @IBOutlet weak var btnLoadMore: UIButton!
    @IBOutlet weak var tableViewOt: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var lblTotalCart: UILabel!
    @IBOutlet weak var lblTotalCount: UILabel!
    @IBOutlet weak var vwCart: UIView!
    
    var idenProduct = "ProductTblCell"
    var arrProducts:[ResProductsByCat] = []
    var arrOrgProducts:[ResProductsByCat] = []
    var categoryId = ""
    var size = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchBar.showsScopeBar = true
        self.searchBar.returnKeyType = .done
        self.tableViewOt.register(UINib(nibName: idenProduct, bundle: nil), forCellReuseIdentifier: idenProduct)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBarItem(LeftTitle: "", LeftImage: "back", CenterTitle: "Items", CenterImage: "", RightTitle: "", RightImage: "", BackgroundColor: k.themeColor, BackgroundImage: "", TextColor: "#FFFFFF", TintColor: "#FFFFFF", Menu: "")
        self.tabBarController?.tabBar.isHidden = true
        self.getProductByCategory()
        self.getCart()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    func getCart() {
        Api.shared.getCart(self) { (response) in
            if let cartCount = response.totalCart, cartCount != "" {
                self.vwCart.isHidden = false
                self.lblTotalCart.text = "\(R.string.localizable.totalCart()) (\(k.currency) \(response.totalAmount ?? ""))"
                self.lblTotalCount.text = response.totalCart ?? ""
            } else {
                self.vwCart.isHidden = true
            }
        }
    }
    
    func paramProductByCategory() -> [String:AnyObject] {
        var dict : [String:AnyObject] = [:]
        dict["user_id"] = k.userDefault.value(forKey: k.session.userId)! as AnyObject
        dict["cat_id"] = self.categoryId as AnyObject
        dict["rest_id"] = k.userDefault.value(forKey: k.session.interestedRestId) as AnyObject
        dict["size"] = k.emptyString as AnyObject
        print(dict)
        return dict
    }
    
    func getProductByCategory() {
        print(self.paramProductByCategory())
        Api.shared.getProductByCategory(self, self.paramProductByCategory()) { (response) in
            if response.count > 0 {
                self.arrProducts = response
                self.arrOrgProducts = response
//                if response.count > 19 {
//                    self.btnLoadMore.isHidden = false
//                } else {
//                    self.btnLoadMore.isHidden = true
//                }
            } else {
                self.arrProducts = []
                self.arrOrgProducts = []
//                self.btnLoadMore.isHidden = true
            }
            self.tableViewOt.reloadData()
        }
    }
    
    func paramLikeUnlike(_ productId: String) -> [String:AnyObject] {
        var dict : [String:AnyObject] = [:]
        dict["user_id"] = k.userDefault.value(forKey: k.session.userId) as AnyObject
        dict["product_id"] = productId as AnyObject
        return dict
    }
    
    func likeUnlike(_ productId: String) {
        Api.shared.likeUnlike(self, self.paramLikeUnlike(productId)) { (response) in
            self.getProductByCategory()
        }
    }
    
//    @IBAction func btnLoadMore(_ sender: UIButton) {
//        self.size = self.size + 20
//        self.getProductByCategory()
//    }
    
    @objc func loadMore() {
        self.size = self.size + 20
        self.getProductByCategory()
    }
    
    @IBAction func btnCart(_ sender: UIButton) {
        let vc = R.storyboard.main().instantiateViewController(withIdentifier: "CartVC") as! CartVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension ProductVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrProducts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.productTblCell, for: indexPath)!
        let obj = self.arrProducts[indexPath.row]
        cell.lblProductName.text = obj.itemName ?? ""
        cell.lblProductDesc.text = obj.descriptionField ?? ""
        cell.lblProductPrice.text = "\(obj.itemPrice ?? "") \(k.currency)"
        if let image = obj.image, image != "" {
            let imgUrl = Router.BASE_IMAGE_URL + image
            Utility.setImageWithSDWebImage(imgUrl, cell.imgProduct)
        }
        
        cell.cloFavourite = { () in
            self.likeUnlike(obj.id ?? "")
        }
        
        cell.cloAdd = { () in
            let vc = R.storyboard.main().instantiateViewController(withIdentifier: "ProductDetailVC") as! ProductDetailVC
            vc.productId = self.arrProducts[indexPath.row].id ?? ""
            self.navigationController?.pushViewController(vc, animated: true)
        }
        return cell
    }
}

extension ProductVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = R.storyboard.main().instantiateViewController(withIdentifier: "ProductDetailVC") as! ProductDetailVC
        vc.productId = self.arrProducts[indexPath.row].id ?? ""
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension ProductVC: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.arrProducts = self.arrOrgProducts
        if searchText != "" {
            let filteredArr = self.arrProducts.filter({ $0.itemName?.range(of: searchText, options: [.diacriticInsensitive, .caseInsensitive]) != nil })
            self.arrProducts = filteredArr
        }
        self.tableViewOt.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.endEditing(true)
    }
}
