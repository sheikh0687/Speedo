//
//  MyFavouriteVC.swift
//  Speedo
//
//  Created by mac on 18/04/21.
//

import UIKit

class MyFavouriteVC: UIViewController {

    @IBOutlet weak var clvProduct: UICollectionView!
    @IBOutlet weak var lblTotalCart: UILabel!
    @IBOutlet weak var lblTotalCount: UILabel!
    @IBOutlet weak var vwCart: UIView!
    
    var idenProduct = "ProductCell"
    var arr:[ResFavourite] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.clvProduct.register(UINib(nibName: idenProduct, bundle: nil), forCellWithReuseIdentifier: idenProduct)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBarItem(LeftTitle: "", LeftImage: "menu", CenterTitle: R.string.localizable.myFavourite(), CenterImage: "", RightTitle: "", RightImage: "", BackgroundColor: k.themeColor, BackgroundImage: "", TextColor: "#FFFFFF", TintColor: "#FFFFFF", Menu: "")
        if Utility.isUserLogin() {
            self.getFavouriteProducts()
            self.getCart()
        }
    }
    
    override func leftClick() {
        toggleLeft()
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
    
    override func rightClick() {
        let vc = R.storyboard.main().instantiateViewController(withIdentifier: "CartVC") as! CartVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func paramFavouriteProducts() -> [String:AnyObject] {
        var dict : [String:AnyObject] = [:]
        dict["user_id"] = k.userDefault.value(forKey: k.session.userId) as AnyObject
        return dict
    }
    
    func getFavouriteProducts() {
        print(self.paramFavouriteProducts())
        Api.shared.getFavouriteRest(self, self.paramFavouriteProducts()) { (response) in
            if response.count > 0 {
                self.arr = response
            } else {
                self.arr = []
            }
            self.clvProduct.reloadData()
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
            self.getFavouriteProducts()
        }
    }
    
    @IBAction func btnCart(_ sender: UIButton) {
        let vc = R.storyboard.main().instantiateViewController(withIdentifier: "CartVC") as! CartVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension MyFavouriteVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.productCell, for: indexPath)!
        let obj = self.arr[indexPath.row]
        cell.lblProductName.text = obj.itemName ?? ""
        cell.lblProductDesc.text = obj.descriptionField ?? ""
        cell.lblProductPrice.text = "\(k.currency) \(obj.itemPrice ?? "")"
        if let image = obj.image, image != "" {
            let imgUrl = Router.BASE_IMAGE_URL + image
            Utility.setImageWithSDWebImage(imgUrl, cell.imgProduct)
        }
        
        let objRest = obj.restDetails
//        cell.lblRestName.text = objRest?.restName ?? ""
//        cell.lblRestDesc.text = objRest?.aboutMe ?? ""
//        cell.lblRestLocation.text = objRest?.address ?? ""
//        Utility.setImageWithSDWebImage(objRest?.restImage ?? "", cell.imgRest)
        if let likeStatus = obj.productLike, likeStatus == "YES" {
            cell.btnFavouriteStatus.setImage(R.image.favoritefill(), for: .normal)
        } else {
            cell.btnFavouriteStatus.setImage(R.image.favoritenill(), for: .normal)
        }
        
        cell.cloFavourite = { () in
            self.likeUnlike(obj.id ?? "")
        }
        
        cell.cloAdd = { () in
            
        }
        return cell
    }
}

extension MyFavouriteVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 135)
    }
}

extension MyFavouriteVC: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = R.storyboard.main().instantiateViewController(withIdentifier: "ProductDetailVC") as! ProductDetailVC
        vc.productId = self.arr[indexPath.row].id ?? ""
        vc.restId = self.arr[indexPath.row].restDetails?.id ?? ""
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
