////
////  ProductDetailVC.swift
////  Speedo
////
////  Created by mac on 20/05/21.
////
//
//import UIKit
//
//class ProductDetailVC: UIViewController {
//    
//    @IBOutlet var imgProduct: UIImageView!
//    @IBOutlet var lblProductName: UILabel!
//    @IBOutlet var lblPrice: UILabel!
//    @IBOutlet weak var lblPriceDesc: UILabel!
//    @IBOutlet var lblQty: UILabel!
//    @IBOutlet weak var btnFav: UIButton!
//    
//    @IBOutlet weak var vwIncludedItemPrice: UIView!
//    @IBOutlet weak var vwPriceWillUp: UIView!
//    @IBOutlet weak var vwChoose1: UIView!
//    @IBOutlet weak var vwChoose2: UIView!
//    @IBOutlet weak var vwChoose3: UIView!
//    @IBOutlet weak var vwChoose4: UIView!
//    
//    @IBOutlet weak var clvPriceGoDown: UICollectionView!
//    @IBOutlet weak var clvSize: UICollectionView!
//    @IBOutlet weak var tblIncludedItemPrice: UITableView!
//    @IBOutlet weak var tblPriceWillUp: UITableView!
//    @IBOutlet weak var tblChoose1: UITableView!
//    @IBOutlet weak var tblChoose2: UITableView!
//    @IBOutlet weak var tblChoose3: UITableView!
//    @IBOutlet weak var tblChoose4: UITableView!
//    
//    @IBOutlet weak var constraintChoose3: NSLayoutConstraint!
//    @IBOutlet weak var constraintIncludedPrice: NSLayoutConstraint!
//    @IBOutlet weak var constraintPriceWillUp: NSLayoutConstraint!
//    @IBOutlet weak var constraintChoose1: NSLayoutConstraint!
//    @IBOutlet weak var constraintChoose2: NSLayoutConstraint!
//    @IBOutlet weak var constraintPriceGoDown: NSLayoutConstraint!
//    
//    @IBOutlet weak var constraintChoose4: NSLayoutConstraint!
//    
//    var productId = ""
//    var productName = ""
//    var categoryId = ""
//    var categoryName = ""
//    var restId = ""
//    var qty = 1
//    var basePrice = 0
//    var basicPrice = 0
//    var price = 0
//    var sizePrice = ""
//    var sizeId = ""
//    var sizeName = ""
//    var totalAmount = 0
//    var companyId = ""
//    
//    var identifier = "SizeCell"
//    var identifierPlusMinus = "ProductPlusMinusCell"
//    var idenCheck = "ProductCheckCell"
//    var idenRadio = "ProductRadioCell"
//    
//    var mainResponse: ResUserProductDetail?
//    var arrSize: [ResProductSize] = []
//    var arrPriceGoDown: [ResProductAdditional] = []
//    var arrIncludeItemPrice: [ResProductAdditional] = []
//    var arrPriceWillUp: [ResProductAdditional] = []
//    var arrChoose1: [ResProductAdditional] = []
//    var arrChoose2: [ResProductAdditional] = []
//    var arrChoose3: [ResProductAdditional] = []
//    var arrChoose4: [ResProductAdditional] = []
//    
//    var cellHeight = 30
//    var selectedIndex = 0
//    var selectedChoose1:Int?
//    var isEverSelected1 = false
//    var lastChoosePrice1 = 0
//    
//    var selectedChoose2:Int?
//    var isEverSelected2 = false
//    var lastChoosePrice2 = 0
//    
//    var selectedChoose3:Int?
//    var isEverSelected3 = false
//    var lastChoosePrice3 = 0
//    
//    var selectedChoose4:Int?
//    var isEverSelected4 = false
//    var lastChoosePrice4 = 0
//    
//    var singleChoose1 = true
//    var singleChoose2 = true
//    var singleChoose3 = true
//    var singleChoose4 = true
//    
//    var arrExtraItemId = [String]()
//    var arrExtraItemPrice = [String]()
//    var arrExtraItemQty = [String]()
//    var arrExtraItemName = [String]()
//    var arrExtraItemQtyPrice = [String]()
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        self.clvSize.register(UINib(nibName: identifier, bundle: nil), forCellWithReuseIdentifier: identifier)
//        self.clvPriceGoDown.register(UINib(nibName: identifier, bundle: nil), forCellWithReuseIdentifier: identifier)
//        self.tblIncludedItemPrice.register(UINib(nibName: idenCheck, bundle: nil), forCellReuseIdentifier: idenCheck)
//        self.tblPriceWillUp.register(UINib(nibName: identifierPlusMinus, bundle: nil), forCellReuseIdentifier: identifierPlusMinus)
//        self.tblChoose1.register(UINib(nibName: idenRadio, bundle: nil), forCellReuseIdentifier: idenRadio)
//        self.tblChoose2.register(UINib(nibName: idenRadio, bundle: nil), forCellReuseIdentifier: idenRadio)
//        self.tblChoose3.register(UINib(nibName: idenRadio, bundle: nil), forCellReuseIdentifier: idenRadio)
//        self.tblChoose4.register(UINib(nibName: idenRadio, bundle: nil), forCellReuseIdentifier: idenRadio)
//    }
//    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        setNavigationBarItem(LeftTitle: "", LeftImage: "back", CenterTitle: R.string.localizable.itemDetail(), CenterImage: "", RightTitle: "", RightImage: "bag", BackgroundColor: k.themeColor, BackgroundImage: "", TextColor: "#FFFFFF", TintColor: "#FFFFFF", Menu: "")
//        self.tabBarController?.tabBar.isHidden = true
//        self.getProductDetail()
//    }
//    
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        self.tabBarController?.tabBar.isHidden = false
//    }
//    
//    override func rightClick() {
//        if Utility.isUserLogin() {
//            let vc = R.storyboard.main().instantiateViewController(withIdentifier: "CartVC") as! CartVC
//            self.navigationController?.pushViewController(vc, animated: true)
//        } else {
//            Utility.showAlertRegistration(parentViewController: self) { (bool) in
//                if bool {
//                    Utility.logoutt()
//                }
//            }
//        }
//    }
//    
//    func paramProductDetail() -> [String:AnyObject] {
//        var dict : [String:AnyObject] = [:]
//        dict["user_id"] = k.userDefault.value(forKey: k.session.userId) as AnyObject
//        dict["product_id"] = self.productId as AnyObject
//        return dict
//    }
//    
//    func getProductDetail() {
//        print(self.paramProductDetail())
//        Api.shared.getProductDetail(self, self.paramProductDetail()) { (response) in
//            self.lblProductName.text = response.itemName ?? ""
//            self.lblPriceDesc.text = response.descriptionField ?? ""
//            self.productName = response.itemName ?? ""
//            self.categoryId = response.catId ?? ""
//            self.categoryName = response.catName ?? ""
//            self.mainResponse = response
//            if response.productSize?.count ?? 0 > 0 {
//                self.changeSize(0, response)
//            }
//            if let productLike = response.productLike, productLike == "NO" {
//                self.btnFav.setImage(R.image.favoritenill(), for: .normal)
//            } else {
//                self.btnFav.setImage(R.image.favoritefill(), for: .normal)
//            }
//        }
//    }
//    
//    func changeSize(_ index: Int, _ response: ResUserProductDetail) {
//        self.arrSize = []
//        self.arrPriceGoDown = []
//        self.arrPriceWillUp = []
//        self.arrIncludeItemPrice = []
//        self.arrChoose1 = []
//        self.arrChoose2 = []
//        self.arrChoose3 = []
//        self.arrChoose4 = []
//        if let img = response.productSize?[index].image, img != Router.BASE_IMAGE_URL && img != "" {
//            Utility.setImageWithSDWebImage(response.productSize?[index].image ?? "", self.imgProduct)
//        } else {
//            Utility.setImageWithSDWebImage("\(Router.BASE_IMAGE_URL)\(response.image ?? "")", self.imgProduct)
//        }
//        
//        self.basePrice = Int(response.productSize?[index].price ?? "") ?? 0
//        self.basicPrice = self.basePrice
//        self.price = self.basePrice * self.qty
//        self.totalAmount = self.basePrice * self.qty
//        self.lblPrice.text = "\(k.currency) \(self.price)"
//        
//        self.arrSize = response.productSize ?? []
//        if let arrAdditional = response.productSize?[index].productAdditional {
//            for item in arrAdditional {
//                if item.priceGoOff == "Yes" {
//                    self.arrPriceWillUp.append(item)
//                } else if item.priceGoDown == "Yes" {
//                    self.arrPriceGoDown.append(item)
//                } else if item.singleChoiceItem == "Yes" {
//                    self.arrChoose1.append(item)
//                } else if item.singleChoiceItem2 == "Yes" {
//                    self.arrChoose2.append(item)
//                } else if item.singleChoiceItem3 == "Yes" {
//                    self.arrChoose3.append(item)
//                } else if item.singleChoiceItem4 == "Yes" {
//                    self.arrChoose4.append(item)
//                } else if item.includeInItemPrice == "Yes" {
//                    self.arrIncludeItemPrice.append(item)
//                }
//            }
//        }
//        
//        self.constraintIncludedPrice.constant = CGFloat((self.arrIncludeItemPrice.count) * self.cellHeight)
//        self.constraintPriceWillUp.constant = CGFloat((self.arrPriceWillUp.count) * self.cellHeight)
//        if self.arrPriceGoDown.count < 2 {
//            self.constraintPriceGoDown.constant = CGFloat((self.arrPriceGoDown.count) * 50)
//        } else {
//            self.constraintPriceGoDown.constant = CGFloat((self.arrPriceGoDown.count) * self.cellHeight)
//        }
//        self.constraintChoose1.constant = CGFloat((self.arrChoose1.count) * self.cellHeight)
//        self.constraintChoose2.constant = CGFloat((self.arrChoose2.count) * self.cellHeight)
//        self.constraintChoose3.constant = CGFloat((self.arrChoose3.count) * self.cellHeight)
//        self.constraintChoose4.constant = CGFloat((self.arrChoose4.count) * self.cellHeight)
//        
//        if self.arrIncludeItemPrice.count > 0 {
//            self.vwIncludedItemPrice.isHidden = false
//        } else {
//            self.vwIncludedItemPrice.isHidden = true
//        }
//        
//        if self.arrPriceWillUp.count > 0 {
//            self.vwPriceWillUp.isHidden = false
//        } else {
//            self.vwPriceWillUp.isHidden = true
//        }
//        
//        if self.arrChoose1.count > 0 {
//            self.vwChoose1.isHidden = false
//            self.singleChoose1 = false
//        } else {
//            self.vwChoose1.isHidden = true
//            self.singleChoose1 = true
//        }
//        
//        if self.arrChoose2.count > 0 {
//            self.vwChoose2.isHidden = false
//            self.singleChoose2 = false
//        } else {
//            self.vwChoose2.isHidden = true
//            self.singleChoose2 = true
//        }
//        
//        if self.arrChoose3.count > 0 {
//            self.vwChoose3.isHidden = false
//            self.singleChoose3 = false
//        } else {
//            self.vwChoose3.isHidden = true
//            self.singleChoose3 = true
//        }
//        
//        if self.arrChoose4.count > 0 {
//            self.vwChoose4.isHidden = false
//            self.singleChoose4 = false
//        } else {
//            self.vwChoose4.isHidden = true
//            self.singleChoose4 = true
//        }
//        
//        self.selectedChoose1 = nil
//        self.isEverSelected1 = false
//        self.lastChoosePrice1 = 0
//        
//        self.selectedChoose2 = nil
//        self.isEverSelected2 = false
//        self.lastChoosePrice2 = 0
//        
//        self.selectedChoose3 = nil
//        self.isEverSelected3 = false
//        self.lastChoosePrice3 = 0
//        
//        self.selectedChoose4 = nil
//        self.isEverSelected4 = false
//        self.lastChoosePrice4 = 0
//        
//        self.clvSize.reloadData()
//        self.clvPriceGoDown.reloadData()
//        self.tblIncludedItemPrice.reloadData()
//        self.tblPriceWillUp.reloadData()
//        self.tblChoose1.reloadData()
//        self.tblChoose2.reloadData()
//        self.tblChoose3.reloadData()
//        self.tblChoose4.reloadData()
//    }
//    
//    @IBAction func btnAdd(_ sender: UIButton) {
//        self.qty = self.qty + 1
//        self.lblQty.text = "\(self.qty)"
//        let nPrice = self.basePrice * self.qty
//        self.lblPrice.text = "\(k.currency) \(nPrice)"
//        self.price = nPrice
//        self.totalAmount = nPrice
//    }
//    
//    @IBAction func btnMinus(_ sender: UIButton) {
//        if self.qty > 1 {
//            self.qty = self.qty - 1
//            self.lblQty.text = "\(self.qty)"
//            let nPrice = self.basePrice * self.qty
//            self.lblPrice.text = "\(k.currency) \(nPrice)"
//            self.totalAmount = nPrice
//            self.price = nPrice
//        }
//    }
//    
//    func paramAddToCart() -> [String:AnyObject] {
//        var dict : [String:AnyObject] = [:]
//        dict["user_id"] = k.userDefault.value(forKey: k.session.userId) as AnyObject
//        dict["product_id"] = self.productId as AnyObject
//        dict["product_name"] = self.productName as AnyObject
//        dict["total_amount"] = self.totalAmount as AnyObject
//        dict["quantity"] = self.qty as AnyObject
//        dict["size_price"] = self.sizePrice as AnyObject
//        dict["size_name"] = self.sizeName as AnyObject
//        dict["size_id"] = self.sizeId as AnyObject
//        dict["extra_item_id"] = self.arrExtraItemId.joined(separator: ",") as AnyObject
//        dict["extra_item_price"] = self.arrExtraItemPrice.joined(separator: ",") as AnyObject
//        dict["extra_item_name"] = self.arrExtraItemName.joined(separator: ",") as AnyObject
//        dict["extra_item_qty"] = self.arrExtraItemQty.joined(separator: ",") as AnyObject
//        dict["total_extra_item_price"] = self.arrExtraItemQtyPrice.joined(separator: ",") as AnyObject
//        dict["company_id"] = k.userDefault.value(forKey: k.session.interestedRestId) as AnyObject
//        dict["cat_id"] = self.categoryId as AnyObject
//        dict["cat_name"] = self.categoryName as AnyObject
//        return dict
//    }
//    
//    func addToCart() {
//        print(self.arrExtraItemId.joined(separator: ","))
//        print(self.arrExtraItemName.joined(separator: ","))
//        print(self.arrExtraItemPrice.joined(separator: ","))
//        print(self.arrExtraItemQty.joined(separator: ","))
//        print(self.arrExtraItemQtyPrice.joined(separator: ","))
//        print(self.paramAddToCart())
//        Api.shared.addCart(self, self.paramAddToCart()) { (response) in
//            Utility.showAlertWithAction(withTitle: "", message: R.string.localizable.itemAddedToCartSuccessfully(), delegate: nil, parentViewController: self) { (bool) in
//                Switcher.updateRootVC()
//            }
//        }
//    }
//    
//    @IBAction func btnFav(_ sender: UIButton) {
//        if Utility.isUserLogin() {
//            self.addToFavourite()
//        } else {
//            Utility.showAlertRegistration(parentViewController: self) { (bool) in
//                if bool {
//                    Utility.logoutt()
//                }
//            }
//        }
//    }
//    
//    func addToFavourite() {
//        Api.shared.tapToFavourite(self, self.paramTapFavourite()) { (response) in
//            if let productLike = response.message, productLike == "unlike successfull" {
//                self.btnFav.setImage(R.image.favoritenill(), for: .normal)
//            } else {
//                self.btnFav.setImage(R.image.favoritefill(), for: .normal)
//            }
//        }
//    }
//    
//    func paramTapFavourite() -> [String:AnyObject] {
//        var dict : [String:AnyObject] = [:]
//        dict["user_id"] = k.userDefault.value(forKey: k.session.userId) as AnyObject
//        dict["product_id"] = self.productId as AnyObject
//        return dict
//    }
//    
//    @IBAction func btnAddToCart(_ sender: UIButton) {
//        if Utility.isUserLogin() {
//            self.addToCartMain()
//        } else {
//            Utility.showAlertRegistration(parentViewController: self) { (bool) in
//                if bool {
//                    Utility.logoutt()
//                }
//            }
//        }
//    }
//    
//    func addToCartMain() {
//        self.calcExtraItem()
//        if self.singleChoose1 == true && self.singleChoose2 == true && self.singleChoose3 == true && self.singleChoose4 == true {
//            if self.totalAmount == 0 {
//                Utility.showAlertMessage(withTitle: k.appName, message: R.string.localizable.youNeedToSelectItemFromBelowList(), delegate: nil, parentViewController: self)
//            } else {
//                self.addToCart()
//            }
//        } else {
//            Utility.showAlertWithAction(withTitle: k.appName, message: R.string.localizable.youNeedToSelectTheAnyOneItemFromAllSingleChoiceMenu(), delegate: nil, parentViewController: self) { (bool) in
//                ""
//            }
//        }
//    }
//    
//    func calcExtraItem() {
//        self.arrExtraItemId = []
//        self.arrExtraItemPrice = []
//        self.arrExtraItemName = []
//        self.arrExtraItemQty = []
//        self.arrExtraItemQtyPrice = []
//        var index1 = 0
//        let cellsIncludedItemPrice = self.tblIncludedItemPrice.visibleCells as! Array<ProductCheckCell>
//        for cell in cellsIncludedItemPrice {
//            if cell.btnCheck.image(for: .normal) == R.image.check_box_fill_18pt() {
//                self.arrExtraItemId.append(self.arrIncludeItemPrice[index1].id ?? "")
//                self.arrExtraItemPrice.append(self.arrIncludeItemPrice[index1].itemPrice ?? "")
//                self.arrExtraItemName.append(self.arrIncludeItemPrice[index1].itemName ?? "")
//                self.arrExtraItemQty.append("1")
//            }
//            index1 = index1 + 1
//        }
//        
//        var index2 = 0
//        let cellChoose1 = self.tblChoose1.visibleCells as! Array<ProductRadioCell>
//        for cell in cellChoose1 {
//            if cell.btnCheck.image(for: .normal) == R.image.radio_check() {
//                self.arrExtraItemId.append(self.arrChoose1[index2].id ?? "")
//                self.arrExtraItemPrice.append(self.arrChoose1[index2].itemPrice ?? "")
//                self.arrExtraItemName.append(self.arrChoose1[index2].itemName ?? "")
//                self.arrExtraItemQty.append("1")
//            }
//            index2 = index2 + 1
//        }
//        
//        var index3 = 0
//        let cellChoose2 = self.tblChoose2.visibleCells as! Array<ProductRadioCell>
//        for cell in cellChoose2 {
//            if cell.btnCheck.image(for: .normal) == R.image.radio_check() {
//                self.arrExtraItemId.append(self.arrChoose2[index3].id ?? "")
//                self.arrExtraItemPrice.append(self.arrChoose2[index3].itemPrice ?? "")
//                self.arrExtraItemName.append(self.arrChoose2[index3].itemName ?? "")
//                self.arrExtraItemQty.append("1")
//            }
//            index3 = index3 + 1
//        }
//        
//        var index4 = 0
//        let cellChoose3 = self.tblChoose3.visibleCells as! Array<ProductRadioCell>
//        for cell in cellChoose3 {
//            if cell.btnCheck.image(for: .normal) == R.image.radio_check() {
//                self.arrExtraItemId.append(self.arrChoose3[index4].id ?? "")
//                self.arrExtraItemPrice.append(self.arrChoose3[index4].itemPrice ?? "")
//                self.arrExtraItemName.append(self.arrChoose3[index4].itemName ?? "")
//                self.arrExtraItemQty.append("1")
//            }
//            index4 = index4 + 1
//        }
//        
//        var index5 = 0
//        let cellChoose4 = self.tblChoose4.visibleCells as! Array<ProductRadioCell>
//        for cell in cellChoose4 {
//            if cell.btnCheck.image(for: .normal) == R.image.radio_check() {
//                self.arrExtraItemId.append(self.arrChoose4[index5].id ?? "")
//                self.arrExtraItemPrice.append(self.arrChoose4[index5].itemPrice ?? "")
//                self.arrExtraItemName.append(self.arrChoose4[index5].itemName ?? "")
//                self.arrExtraItemQty.append("1")
//            }
//            index5 = index5 + 1
//        }
//        
//        var index6 = 0
//        let cellsPriceWillUp = self.tblPriceWillUp.visibleCells as! Array<ProductPlusMinusCell>
//        for cell in cellsPriceWillUp {
//            if cell.btnCheck.image(for: .normal) == R.image.check_box_fill_18pt() {
//                self.arrExtraItemId.append(self.arrPriceWillUp[index6].id ?? "")
//                self.arrExtraItemPrice.append(self.arrPriceWillUp[index6].itemPrice ?? "")
//                self.arrExtraItemName.append("\(cell.lblQty.text!) x \(self.arrPriceWillUp[index6].itemName ?? "")")
//                self.arrExtraItemQty.append(cell.lblQty.text!)
//                
//                var tot = 0.0
//                if let price = self.arrPriceWillUp[index6].itemPrice, price != "" && price != "0.0" && price != "0" && price != "00" {
//                    let updatedString = price.removingWhitespaces()
//                    let fprice = Double(updatedString) ?? 0.0
//                    let fqty = Double(cell.lblQty.text!) ?? 0.0
//                    tot = fprice * fqty
//                }
//                arrExtraItemQtyPrice.append(String(tot))
//            }
//            index6 = index6 + 1
//        }
//        
//        var index7 = 0
//        let cellsPriceGoDown = self.clvPriceGoDown.visibleCells as! Array<SizeCell>
//        for cell in cellsPriceGoDown {
//            print(cell.lbl.text)
//            let indexPath = IndexPath(row: index7, section: 0)
//            if cell.vw.backgroundColor == UIColor.lightGray {
//                self.arrExtraItemId.append(self.arrPriceGoDown[indexPath.row].id ?? "")
//                self.arrExtraItemPrice.append(self.arrPriceGoDown[index7].itemPrice ?? "")
//                self.arrExtraItemName.append(self.arrPriceGoDown[indexPath.row].itemName ?? "")
//                print(self.arrPriceGoDown[indexPath.row].itemName ?? "")
//                self.arrExtraItemQty.append("1")
//            }
//            index7 = index7 + 1
//        }
//    }
//}
//
//extension ProductDetailVC: UICollectionViewDataSource {
//    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        if collectionView == self.clvSize {
//            return self.arrSize.count
//        } else {
//            return self.arrPriceGoDown.count
//        }
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        if collectionView == self.clvSize {
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.sizeCell, for: indexPath)!
//            let obj = self.arrSize[indexPath.row]
//            cell.lbl.text = self.arrSize[indexPath.row].size ?? ""
//            cell.vw.backgroundColor = .systemGroupedBackground
//            cell.lbl.textColor = .black
//            if indexPath.row == self.selectedIndex {
//                cell.vw.backgroundColor = R.color.theme_color()
//                self.sizeId = obj.id ?? ""
//                self.sizeName = obj.size ?? ""
//                self.sizePrice = obj.price ?? ""
////                self.totalAmount = Int(obj.price ?? "") ?? 0
//                let pprice = Int(obj.price ?? "") ?? 0
//                self.totalAmount = pprice * self.qty
//                print(self.totalAmount)
//            }
//            return cell
//        } else {
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.sizeCell, for: indexPath)!
//            let obj = self.arrPriceGoDown[indexPath.row]
//            if let price = obj.itemPrice, price != "" && price != "0.0" && price != "0" && price != "00" {
//                cell.lbl.text = "\(obj.itemName ?? "") \(price) \(k.currency)"
//            } else {
//                cell.lbl.text = obj.itemName ?? ""
//            }
//            cell.vw.backgroundColor = hexStringToUIColor(hex: "#1E8F12")
//            return cell
//        }
//    }
//}
//
//extension ProductDetailVC: UICollectionViewDelegateFlowLayout {
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        if collectionView == self.clvSize {
//            return CGSize(width: 125, height: 50)
//        } else {
//            return CGSize(width: self.clvPriceGoDown.frame.width / 2, height: 50)
//        }
//    }
//}
//
//extension ProductDetailVC: UICollectionViewDelegate {
//    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        if collectionView == self.clvSize {
//            let cell = collectionView.cellForItem(at: indexPath) as! SizeCell
//            cell.vw.backgroundColor = R.color.theme_color()
//            let obj = self.arrSize[indexPath.row]
//            self.sizeId = obj.id ?? ""
//            self.sizeName = obj.size ?? ""
//            self.sizePrice = obj.price ?? ""
//            
//           // self.lblPrice.text = "\(k.currency) \(obj.price ?? "")"
//            let bPrice = Int(obj.price ?? "") ?? 0
//            let nPrice = bPrice * self.qty
//            print(nPrice)
//            self.price = nPrice
//            self.lblPrice.text = "\(k.currency)\(nPrice)"
//            self.totalAmount = nPrice
//            
//            let indexPaths = collectionView.indexPathsForVisibleItems
//            for indexPathOth in indexPaths {
//                if indexPathOth.row != indexPath.row && indexPathOth.section == indexPath.section {
//                    let cell1 = collectionView.cellForItem(at: IndexPath(row: indexPathOth.row, section: indexPathOth.section)) as! SizeCell
//                    cell1.vw.backgroundColor = .systemGroupedBackground
//                }
//            }
//            self.selectedIndex = indexPath.row
//            self.changeSize(indexPath.row, self.mainResponse!)
//        } else {
//            let cell = collectionView.cellForItem(at: indexPath) as! SizeCell
//            if cell.vw.backgroundColor == hexStringToUIColor(hex: "#1E8F12") {
//                cell.vw.backgroundColor = .lightGray
//                cell.lbl.textColor = .black
//                let obj = self.arrPriceGoDown[indexPath.row]
//                if let price = obj.itemPrice, price != "" && price != "0.0" && price != "0" && price != "00" {
//                    let priceTemp = Int(price) ?? 0
//                    let nPrice = priceTemp * self.qty
//                    print(nPrice)
//                    self.totalAmount = self.totalAmount - nPrice
//                    self.lblPrice.text = "\(self.totalAmount) \(k.currency)"
//                }
//                cell.isSelected = false
//            } else {
//                cell.isSelected = true
//                cell.vw.backgroundColor = hexStringToUIColor(hex: "#1E8F12")
//                cell.lbl.textColor = .white
//                let obj = self.arrPriceGoDown[indexPath.row]
//                if let price = obj.itemPrice, price != "" && price != "0.0" && price != "0" && price != "00" {
//                    let priceTemp = Int(price) ?? 0
//                    let newPriceTemp = priceTemp * self.qty
//                    self.totalAmount = self.totalAmount + newPriceTemp
//                    self.lblPrice.text = "\(self.totalAmount) \(k.currency)"
//                }
//            }
//        }
//    }
//}
//
//extension ProductDetailVC: UITableViewDataSource {
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if tableView == self.tblPriceWillUp {
//            return self.arrPriceWillUp.count
//        } else if tableView == self.tblIncludedItemPrice {
//            return self.arrIncludeItemPrice.count
//        } else if tableView == self.tblChoose1 {
//            return self.arrChoose1.count
//        } else if tableView == self.tblChoose2 {
//            return self.arrChoose2.count
//        } else if tableView == self.tblChoose3 {
//            return self.arrChoose3.count
//        } else {
//            return self.arrChoose4.count
//        }
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if tableView == self.tblPriceWillUp {
//            let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.productPlusMinusCell, for: indexPath)!
//            cell.lblItemName.text = self.arrPriceWillUp[indexPath.row].itemName ?? ""
//            if let price = self.arrPriceWillUp[indexPath.row].itemPrice, price != "" && price != "0.0" && price != "0" && price != "00" {
//                cell.lblPrice.text = "\(k.currency)\(self.arrPriceWillUp[indexPath.row].itemPrice ?? "")"
//            } else {
//                cell.lblPrice.text = ""
//            }
//            cell.btnCheck.setImage(R.image.check_box_nill_18pt(), for: .normal)
//            cell.cloCheck = {(isCheck) in
//                let priceStr = self.arrPriceWillUp[indexPath.row].itemPrice ?? ""
//                let priceInt = Int(priceStr) ?? 0
//                let cellQty = cell.lblQty.text
//                let qty = Int(cellQty ?? "0") ?? 0
//                if isCheck {
//                    print(self.basePrice)
//                    let aprice = self.totalAmount + (priceInt * qty)
//                    let mainQty = Int(self.lblQty.text ?? "0") ?? 0
//                    self.totalAmount = aprice * mainQty
//                } else {
//                    let aprice = self.totalAmount - (priceInt * qty)
//                    let mainQty = Int(self.lblQty.text ?? "0") ?? 0
//                    self.totalAmount = aprice * mainQty
//                }
//                self.lblPrice.text = "\(self.totalAmount) \(k.currency)"
//            }
//            
//            cell.cloUpdate = {(isCheck, isPlus) in
//                let priceStr = self.arrPriceWillUp[indexPath.row].itemPrice ?? ""
//                let priceInt = Int(priceStr) ?? 0
//                let cellQty = cell.lblQty.text
//                let qty = Int(cellQty ?? "0") ?? 0
//                
//                if isCheck {
////                    if isPlus {
////                        let aprice = self.basePrice + (priceInt * qty)
////                        let mainQty = Int(self.lblQty.text ?? "0") ?? 0
////                        self.totalAmount = aprice * mainQty
////                    } else {
////                        let aprice = self.totalAmount - (priceInt * qty)
////                        let mainQty = Int(self.lblQty.text ?? "0") ?? 0
////                        self.totalAmount = aprice * mainQty
////                    }
//                    let aprice = self.totalAmount + (priceInt * qty)
//                    let mainQty = Int(self.lblQty.text ?? "0") ?? 0
//                    self.totalAmount = aprice * mainQty
//                    self.lblPrice.text = "\(self.totalAmount) \(k.currency)"
//                }
//            }
//            return cell
//        } else if tableView == self.tblIncludedItemPrice {
//            let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.productCheckCell, for: indexPath)!
//            cell.lblItemName.text = self.arrIncludeItemPrice[indexPath.row].itemName ?? ""
//            if let price = self.arrIncludeItemPrice[indexPath.row].itemPrice, price != "" && price != "0.0" && price != "0" && price != "00" {
//                cell.lblPrice.text = "\(k.currency)\(self.arrIncludeItemPrice[indexPath.row].itemPrice ?? "")"
//            } else {
//                cell.lblPrice.text = ""
//            }
//            return cell
//        } else if tableView == self.tblChoose1 {
//            let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.productRadioCell, for: indexPath)!
//            cell.lblItemName.text = self.arrChoose1[indexPath.row].itemName ?? ""
//            if let price = self.arrChoose1[indexPath.row].itemPrice, price != "" && price != "0.0" && price != "0" && price != "00" {
//                cell.lblPrice.text = "\(k.currency)\(self.arrChoose1[indexPath.row].itemPrice ?? "")"
//            } else {
//                cell.lblPrice.text = ""
//            }
//            
//            cell.btnCheck.setImage(R.image.radio_uncheck(), for: .normal)
//            if (self.selectedChoose1 != nil) {
//                if indexPath.row == self.selectedChoose1 {
//                    cell.btnCheck.setImage(R.image.radio_check(), for: .normal)
//                }
//            }
//            cell.cloCheck = {() in
//                self.singleChoose1 = true
//                self.selectedChoose1 = indexPath.row
//                self.tblChoose1.reloadData()
//                
//                if self.isEverSelected1 {
//                    self.totalAmount = self.totalAmount - self.lastChoosePrice1
//                }
//                self.lastChoosePrice1 = Int(self.arrChoose1[indexPath.row].itemPrice ?? "") ?? 0
//                let priceCurrent = Int(self.arrChoose1[indexPath.row].itemPrice ?? "") ?? 0
//                self.totalAmount = self.totalAmount + priceCurrent
//                self.lblPrice.text = "\(self.totalAmount)\(k.currency)"
//                self.isEverSelected1 = true
//            }
//            
//            if indexPath.row == 0 {
//                if self.selectedChoose1 == nil {
//                    self.singleChoose1 = true
//                    self.selectedChoose1 = indexPath.row
//                    cell.btnCheck.setImage(R.image.radio_check(), for: .normal)
//                    
//                    if self.isEverSelected1 {
//                        self.totalAmount = self.totalAmount - self.lastChoosePrice1
//                    }
//                    self.lastChoosePrice1 = Int(self.arrChoose1[indexPath.row].itemPrice ?? "") ?? 0
//                    let priceCurrent = Int(self.arrChoose1[indexPath.row].itemPrice ?? "") ?? 0
//                    self.totalAmount = self.totalAmount + priceCurrent
//                    self.lblPrice.text = "\(self.totalAmount)\(k.currency)"
//                    self.isEverSelected1 = true
//                }
//            }
//            return cell
//        } else if tableView == self.tblChoose2 {
//            let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.productRadioCell, for: indexPath)!
//            cell.lblItemName.text = self.arrChoose2[indexPath.row].itemName ?? ""
//            if let price = self.arrChoose2[indexPath.row].itemPrice, price != "" && price != "0.0" && price != "0" && price != "00" {
//                cell.lblPrice.text = "\(k.currency)\(self.arrChoose2[indexPath.row].itemPrice ?? "")"
//            } else {
//                cell.lblPrice.text = ""
//            }
//            
//            cell.btnCheck.setImage(R.image.radio_uncheck(), for: .normal)
//            if (self.selectedChoose2 != nil) {
//                if indexPath.row == self.selectedChoose2 {
//                    cell.btnCheck.setImage(R.image.radio_check(), for: .normal)
//                }
//            }
//            cell.cloCheck = {() in
//                self.singleChoose2 = true
//                self.selectedChoose2 = indexPath.row
//                self.tblChoose2.reloadData()
//                
//                if self.isEverSelected2 {
//                    self.totalAmount = self.totalAmount - self.lastChoosePrice2
//                }
//                self.lastChoosePrice2 = Int(self.arrChoose2[indexPath.row].itemPrice ?? "") ?? 0
//                let priceCurrent = Int(self.arrChoose2[indexPath.row].itemPrice ?? "") ?? 0
//                self.totalAmount = self.totalAmount + priceCurrent
//                self.lblPrice.text = "\(self.totalAmount)\(k.currency)"
//                self.isEverSelected2 = true
//            }
//            
//            if indexPath.row == 0 {
//                if self.selectedChoose2 == nil {
//                    self.singleChoose2 = true
//                    self.selectedChoose2 = indexPath.row
//                    self.tblChoose2.reloadData()
//                    
//                    if self.isEverSelected2 {
//                        self.totalAmount = self.totalAmount - self.lastChoosePrice2
//                    }
//                    self.lastChoosePrice2 = Int(self.arrChoose2[indexPath.row].itemPrice ?? "") ?? 0
//                    let priceCurrent = Int(self.arrChoose2[indexPath.row].itemPrice ?? "") ?? 0
//                    self.totalAmount = self.totalAmount + priceCurrent
//                    self.lblPrice.text = "\(self.totalAmount)\(k.currency)"
//                    self.isEverSelected2 = true
//                }
//            }
//            return cell
//        } else if tableView == self.tblChoose3 {
//            let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.productRadioCell, for: indexPath)!
//            cell.lblItemName.text = self.arrChoose3[indexPath.row].itemName ?? ""
//            if let price = self.arrChoose3[indexPath.row].itemPrice, price != "" && price != "0.0" && price != "0" && price != "00" {
//                cell.lblPrice.text = "\(k.currency)\(self.arrChoose3[indexPath.row].itemPrice ?? "")"
//            } else {
//                cell.lblPrice.text = ""
//            }
//            cell.btnCheck.setImage(R.image.radio_uncheck(), for: .normal)
//            if (self.selectedChoose3 != nil) {
//                if indexPath.row == self.selectedChoose3 {
//                    cell.btnCheck.setImage(R.image.radio_check(), for: .normal)
//                }
//            }
//            cell.cloCheck = {() in
//                self.singleChoose3 = true
//                self.selectedChoose3 = indexPath.row
//                self.tblChoose3.reloadData()
//                
//                if self.isEverSelected3 {
//                    self.totalAmount = self.totalAmount - self.lastChoosePrice3
//                }
//                self.lastChoosePrice3 = Int(self.arrChoose3[indexPath.row].itemPrice ?? "") ?? 0
//                let priceCurrent = Int(self.arrChoose3[indexPath.row].itemPrice ?? "") ?? 0
//                self.totalAmount = self.totalAmount + priceCurrent
//                self.lblPrice.text = "\(self.totalAmount)\(k.currency)"
//                self.isEverSelected3 = true
//            }
//            if indexPath.row == 0 {
//                if self.selectedChoose3 == nil {
//                    self.singleChoose3 = true
//                    self.selectedChoose3 = indexPath.row
//                    self.tblChoose3.reloadData()
//                    
//                    if self.isEverSelected3 {
//                        self.totalAmount = self.totalAmount - self.lastChoosePrice3
//                    }
//                    self.lastChoosePrice3 = Int(self.arrChoose3[indexPath.row].itemPrice ?? "") ?? 0
//                    let priceCurrent = Int(self.arrChoose3[indexPath.row].itemPrice ?? "") ?? 0
//                    self.totalAmount = self.totalAmount + priceCurrent
//                    self.lblPrice.text = "\(self.totalAmount)\(k.currency)"
//                    self.isEverSelected3 = true
//                }
//            }
//            return cell
//        } else {
//            let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.productRadioCell, for: indexPath)!
//            cell.lblItemName.text = self.arrChoose4[indexPath.row].itemName ?? ""
//            if let price = self.arrChoose4[indexPath.row].itemPrice, price != "" && price != "0.0" && price != "0" && price != "00" {
//                cell.lblPrice.text = "\(k.currency)\(self.arrChoose4[indexPath.row].itemPrice ?? "")"
//            } else {
//                cell.lblPrice.text = ""
//            }
//            cell.btnCheck.setImage(R.image.radio_uncheck(), for: .normal)
//            if (self.selectedChoose4 != nil) {
//                if indexPath.row == self.selectedChoose4 {
//                    cell.btnCheck.setImage(R.image.radio_check(), for: .normal)
//                }
//            }
//            cell.cloCheck = {() in
//                self.singleChoose4 = true
//                self.selectedChoose4 = indexPath.row
//                self.tblChoose4.reloadData()
//                
//                if self.isEverSelected4 {
//                    self.totalAmount = self.totalAmount - self.lastChoosePrice4
//                }
//                self.lastChoosePrice4 = Int(self.arrChoose4[indexPath.row].itemPrice ?? "") ?? 0
//                let priceCurrent = Int(self.arrChoose4[indexPath.row].itemPrice ?? "") ?? 0
//                self.totalAmount = self.totalAmount + priceCurrent
//                self.lblPrice.text = "\(self.totalAmount)\(k.currency)"
//                self.isEverSelected4 = true
//            }
//            
//            if indexPath.row == 0 {
//                if self.selectedChoose4 == nil {
//                    self.singleChoose4 = true
//                    self.selectedChoose4 = indexPath.row
//                    self.tblChoose4.reloadData()
//                    
//                    if self.isEverSelected4 {
//                        self.totalAmount = self.totalAmount - self.lastChoosePrice4
//                    }
//                    self.lastChoosePrice4 = Int(self.arrChoose4[indexPath.row].itemPrice ?? "") ?? 0
//                    let priceCurrent = Int(self.arrChoose4[indexPath.row].itemPrice ?? "") ?? 0
//                    self.totalAmount = self.totalAmount + priceCurrent
//                    self.lblPrice.text = "\(self.totalAmount)\(k.currency)"
//                    self.isEverSelected4 = true
//                }
//            }
//            return cell
//        }
//    }
//}
//
//extension ProductDetailVC: UITableViewDelegate {
//    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 30
//    }
//}
