//
//  ProductDetailVC.swift
//  Speedo
//
//  Created by mac on 20/05/21.
//

import UIKit

class ProductDetailVC: UIViewController {
    
    @IBOutlet var imgProduct: UIImageView!
    @IBOutlet var lblProductName: UILabel!
    @IBOutlet var lblPrice: UILabel!
    @IBOutlet weak var lblPriceDesc: UILabel!
    @IBOutlet var lblQty: UILabel!
    @IBOutlet weak var btnFav: UIButton!
    
    @IBOutlet weak var vwIncludedItemPrice: UIView!
    @IBOutlet weak var vwPriceWillUp: UIView!
    @IBOutlet weak var vwChoose1: UIView!
    @IBOutlet weak var vwChoose2: UIView!
    @IBOutlet weak var vwChoose3: UIView!
    @IBOutlet weak var vwChoose4: UIView!
    
    @IBOutlet weak var clvPriceGoDown: UICollectionView!
    @IBOutlet weak var clvSize: UICollectionView!
    @IBOutlet weak var tblIncludedItemPrice: UITableView!
    @IBOutlet weak var tblPriceWillUp: UITableView!
    @IBOutlet weak var tblChoose1: UITableView!
    @IBOutlet weak var tblChoose2: UITableView!
    @IBOutlet weak var tblChoose3: UITableView!
    @IBOutlet weak var tblChoose4: UITableView!
    
    @IBOutlet weak var constraintChoose3: NSLayoutConstraint!
    @IBOutlet weak var constraintIncludedPrice: NSLayoutConstraint!
    @IBOutlet weak var constraintPriceWillUp: NSLayoutConstraint!
    @IBOutlet weak var constraintChoose1: NSLayoutConstraint!
    @IBOutlet weak var constraintChoose2: NSLayoutConstraint!
    @IBOutlet weak var constraintPriceGoDown: NSLayoutConstraint!
    
    @IBOutlet weak var constraintChoose4: NSLayoutConstraint!
    @IBOutlet weak var btnExtraItem: UIButton!
    
    var productId = ""
    var productName = ""
    var categoryId = ""
    var categoryName = ""
    var restId = ""
    var qty = 1
    var basePrice = 0
    var price = 0
    var sizePrice = ""
    var sizeId = ""
    var sizeName = ""
    var totalAmount = 0
    var companyId = ""
    
    var identifier = "SizeCell"
    var identifierPlusMinus = "ProductPlusMinusCell"
    var idenCheck = "ProductCheckCell"
    var idenRadio = "ProductRadioCell"
    
    var mainResponse: ResUserProductDetail?
//    var arrSize: [ResProductSize] = []
//    var arrPriceGoDown: [ResProductAdditional] = []
    var arrSize:[myArrSize] = []
    var arrPriceGoDown: [myArrPriceGoDown] = []
    var arrIncludeItemPrice: [ResProductAdditional] = []
    var arrPriceWillUp: [myArrPriceWillUp] = []
    var arrChoose1: [myArrChoose1] = []
    var arrChoose2: [myArrChoose2] = []
    var arrChoose3: [myArrChoose3] = []
    var arrChoose4: [myArrChoose4] = []
    
    var cellHeight = 30
    var selectedIndex = 0
    var selectedChoose1:Int?
    var isEverSelected1 = false
    var lastChoosePrice1 = 0
    
    var selectedChoose2:Int?
    var isEverSelected2 = false
    var lastChoosePrice2 = 0
    
    var selectedChoose3:Int?
    var isEverSelected3 = false
    var lastChoosePrice3 = 0
    
    var selectedChoose4:Int?
    var isEverSelected4 = false
    var lastChoosePrice4 = 0
    
    var singleChoose1 = true
    var singleChoose2 = true
    var singleChoose3 = true
    var singleChoose4 = true
    
    var arrExtraItemId = [String]()
    var arrExtraItemPrice = [String]()
    var arrExtraItemQty = [String]()
    var arrExtraItemName = [String]()
    var arrExtraItemQtyPrice = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.clvSize.register(UINib(nibName: identifier, bundle: nil), forCellWithReuseIdentifier: identifier)
        self.clvPriceGoDown.register(UINib(nibName: identifier, bundle: nil), forCellWithReuseIdentifier: identifier)
        self.tblIncludedItemPrice.register(UINib(nibName: idenCheck, bundle: nil), forCellReuseIdentifier: idenCheck)
        self.tblPriceWillUp.register(UINib(nibName: identifierPlusMinus, bundle: nil), forCellReuseIdentifier: identifierPlusMinus)
        self.tblChoose1.register(UINib(nibName: idenRadio, bundle: nil), forCellReuseIdentifier: idenRadio)
        self.tblChoose2.register(UINib(nibName: idenRadio, bundle: nil), forCellReuseIdentifier: idenRadio)
        self.tblChoose3.register(UINib(nibName: idenRadio, bundle: nil), forCellReuseIdentifier: idenRadio)
        self.tblChoose4.register(UINib(nibName: idenRadio, bundle: nil), forCellReuseIdentifier: idenRadio)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBarItem(LeftTitle: "", LeftImage: "back", CenterTitle: R.string.localizable.itemDetail(), CenterImage: "", RightTitle: "", RightImage: "bag", BackgroundColor: k.themeColor, BackgroundImage: "", TextColor: "#FFFFFF", TintColor: "#FFFFFF", Menu: "")
        self.tabBarController?.tabBar.isHidden = true
        self.getProductDetail()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func rightClick() {
        if Utility.isUserLogin() {
            let vc = R.storyboard.main().instantiateViewController(withIdentifier: "CartVC") as! CartVC
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            Utility.showAlertRegistration(parentViewController: self) { (bool) in
                if bool {
                    Utility.logoutt()
                }
            }
        }
    }
    
    func paramProductDetail() -> [String:AnyObject] {
        var dict : [String:AnyObject] = [:]
        dict["user_id"] = k.userDefault.value(forKey: k.session.userId) as AnyObject
        dict["product_id"] = self.productId as AnyObject
        print(dict)
        return dict
    }
    
    func getProductDetail() {
        print(self.paramProductDetail())
        Api.shared.getProductDetail(self, self.paramProductDetail()) { (response) in
            self.lblProductName.text = response.itemName ?? ""
            self.lblPriceDesc.text = response.descriptionField ?? ""
            self.productName = response.itemName ?? ""
            self.categoryId = response.catId ?? ""
            self.categoryName = response.catName ?? ""
            self.mainResponse = response
            if response.productSize?.count ?? 0 > 0 {
                self.changeSize(0, response)
            }
            if let productLike = response.productLike, productLike == "NO" {
                self.btnFav.setImage(R.image.favoritenill(), for: .normal)
            } else {
                self.btnFav.setImage(R.image.favoritefill(), for: .normal)
            }
        }
    }
    
    func calculationOfPrice() {
        var basePrice = 0
        var qty = 0
        var basicPrice = 0
        var totalAmount = 0
        
        qty = self.qty
        for val in self.arrSize {
            if val.isSelected {
                basePrice = Int(val.arrSize.price ?? "") ?? 0
                basicPrice = basePrice * qty
            }
        }
        
        var priceGoDownMinus = 0
        var priceGoDownAdd = 0
        for val in self.arrPriceGoDown {
            if val.isConsiderInCal {
                if val.isSelected {
                    if let price = val.arrPriceGoDown.itemPrice, price != "" && price != "0.0" && price != "0" && price != "00" {
                        let priceTemp = Int(price) ?? 0
                        let nPrice = priceTemp * self.qty
                        priceGoDownAdd = priceGoDownAdd + nPrice
                    }
                } else {
                    if let price = val.arrPriceGoDown.itemPrice, price != "" && price != "0.0" && price != "0" && price != "00" {
                        let priceTemp = Int(price) ?? 0
                        let nPrice = priceTemp * self.qty
                        priceGoDownMinus = priceGoDownMinus + nPrice
                    }
                }
            }
        }
        
        var priceWillUp = 0
        for val in self.arrPriceWillUp {
            if val.isSelected {
                let priceStr = val.arrPriceWillUp.itemPrice ?? ""
                let priceInt = Int(priceStr) ?? 0
                let qtyy = val.qty
                priceWillUp = priceWillUp + ((priceInt * qtyy) * qty)
            }
        }
        
        var priceChoose1 = 0
        for val in self.arrChoose1 {
            if val.isSelected {
                let priceStr = val.arrChoose1.itemPrice ?? ""
                let priceInt = Int(priceStr) ?? 0
                let qty = val.qty
                priceChoose1 = priceChoose1 + (priceInt * qty)
            }
        }
        
        var priceChoose2 = 0
        for val in self.arrChoose2 {
            if val.isSelected {
                let priceStr = val.arrChoose2.itemPrice ?? ""
                let priceInt = Int(priceStr) ?? 0
                let qty = val.qty
                priceChoose2 = priceChoose2 + (priceInt * qty)
            }
        }
        
        totalAmount = ((basicPrice + priceWillUp + priceChoose1 + priceChoose2) - priceGoDownMinus)
        self.totalAmount = totalAmount
        self.lblPrice.text = "\(k.currency) \(totalAmount)"
    }
    
    func changeSize(_ index: Int, _ response: ResUserProductDetail) {
        self.arrSize = []
        self.arrPriceGoDown = []
        self.arrPriceWillUp = []
        self.arrIncludeItemPrice = []
        self.arrChoose1 = []
        self.arrChoose2 = []
        self.arrChoose3 = []
        self.arrChoose4 = []
        
        self.basePrice = Int(response.productSize?[index].price ?? "") ?? 0
        self.price = self.basePrice * self.qty
        self.totalAmount = self.basePrice * self.qty
        self.lblPrice.text = "\(k.currency) \(self.price)"
                
        if let arr = response.productSize, arr.count > 0 {
            for (indexTemp, val) in arr.enumerated() {
                if indexTemp == index {
                    self.arrSize.append(myArrSize(arrSize: val, isSelected: true))
                } else {
                    self.arrSize.append(myArrSize(arrSize: val, isSelected: false))
                }
            }
        }
        
        var tempArrPriceGoDown:[ResProductAdditional] = []
        var tempArrPriceWillUp:[ResProductAdditional] = []
        var tempArrChoose1:[ResProductAdditional] = []
        var tempArrChoose2:[ResProductAdditional] = []
        var tempArrChoose3:[ResProductAdditional] = []
        var tempArrChoose4:[ResProductAdditional] = []
        if let arrAdditional = response.productSize?[index].productAdditional {
            for item in arrAdditional {
                if item.priceGoOff == "Yes" {
                    tempArrPriceWillUp.append(item)
                } else if item.priceGoDown == "Yes" {
                    tempArrPriceGoDown.append(item)
                } else if item.singleChoiceItem == "Yes" {
                    tempArrChoose1.append(item)
                } else if item.singleChoiceItem2 == "Yes" {
                    tempArrChoose2.append(item)
                } else if item.singleChoiceItem3 == "Yes" {
                    tempArrChoose3.append(item)
                } else if item.singleChoiceItem4 == "Yes" {
                    tempArrChoose4.append(item)
                } else if item.includeInItemPrice == "Yes" {
                    self.arrIncludeItemPrice.append(item)
                }
            }
        }
        
        for val in tempArrPriceGoDown {
            self.arrPriceGoDown.append(myArrPriceGoDown(arrPriceGoDown: val, isSelected: true, isConsiderInCal: false))
        }
        for val in tempArrPriceWillUp {
            self.arrPriceWillUp.append(myArrPriceWillUp(arrPriceWillUp: val, isSelected: false, qty: 1))
        }
        for (_, val) in tempArrChoose1.enumerated() {
            if val.default_selected == "Yes" {
                self.arrChoose1.append(myArrChoose1(arrChoose1: val, isSelected: true, qty: 1))
            } else {
                self.arrChoose1.append(myArrChoose1(arrChoose1: val, isSelected: false, qty: 1))
            }
        }
        for (_, val) in tempArrChoose2.enumerated() {
            if val.default_selected == "Yes" {
                self.arrChoose2.append(myArrChoose2(arrChoose2: val, isSelected: true, qty: 1))
            } else {
                self.arrChoose2.append(myArrChoose2(arrChoose2: val, isSelected: false, qty: 1))
            }
        }
        for (_, val) in tempArrChoose3.enumerated() {
            if val.default_selected == "Yes" {
                self.arrChoose3.append(myArrChoose3(arrChoose3: val, isSelected: true, qty: 1))
            } else {
                self.arrChoose3.append(myArrChoose3(arrChoose3: val, isSelected: false, qty: 1))
            }
        }
        for (_, val) in tempArrChoose4.enumerated() {
            if val.default_selected == "Yes" {
                self.arrChoose4.append(myArrChoose4(arrChoose4: val, isSelected: true, qty: 1))
            } else {
                self.arrChoose4.append(myArrChoose4(arrChoose4: val, isSelected: false, qty: 1))
            }
        }
        
        self.constraintIncludedPrice.constant = CGFloat((self.arrIncludeItemPrice.count) * self.cellHeight)
        self.constraintPriceWillUp.constant = CGFloat((self.arrPriceWillUp.count) * self.cellHeight)
        if self.arrPriceGoDown.count < 2 {
            self.constraintPriceGoDown.constant = CGFloat((self.arrPriceGoDown.count) * 50)
        } else {
            self.constraintPriceGoDown.constant = CGFloat((self.arrPriceGoDown.count) * self.cellHeight)
        }
        self.constraintChoose1.constant = CGFloat((self.arrChoose1.count) * self.cellHeight)
        self.constraintChoose2.constant = CGFloat((self.arrChoose2.count) * self.cellHeight)
        self.constraintChoose3.constant = CGFloat((self.arrChoose3.count) * self.cellHeight)
        self.constraintChoose4.constant = CGFloat((self.arrChoose4.count) * self.cellHeight)
        
        if self.arrIncludeItemPrice.count > 0 {
            self.vwIncludedItemPrice.isHidden = false
        } else {
            self.vwIncludedItemPrice.isHidden = true
        }
        
       // if self.arrPriceWillUp.count > 0 {
         //   self.vwPriceWillUp.isHidden = false
       // } else {
        self.btnExtraItem.setImage(R.image.downarrow(), for: .normal)
            self.vwPriceWillUp.isHidden = true
       // }
        
        if self.arrChoose1.count > 0 {
            self.vwChoose1.isHidden = false
        } else {
            self.vwChoose1.isHidden = true
            self.singleChoose1 = true
        }
        
        if self.arrChoose2.count > 0 {
            self.vwChoose2.isHidden = false
        } else {
            self.vwChoose2.isHidden = true
            self.singleChoose2 = true
        }
        
        if self.arrChoose3.count > 0 {
            self.vwChoose3.isHidden = false
        } else {
            self.vwChoose3.isHidden = true
            self.singleChoose3 = true
        }
        
        if self.arrChoose4.count > 0 {
            self.vwChoose4.isHidden = false
        } else {
            self.vwChoose4.isHidden = true
            self.singleChoose4 = true
        }
        
        self.selectedChoose1 = nil
        self.isEverSelected1 = false
        self.lastChoosePrice1 = 0
        
        self.selectedChoose2 = nil
        self.isEverSelected2 = false
        self.lastChoosePrice2 = 0
        
        self.selectedChoose3 = nil
        self.isEverSelected3 = false
        self.lastChoosePrice3 = 0
        
        self.selectedChoose4 = nil
        self.isEverSelected4 = false
        self.lastChoosePrice4 = 0
        
        if let img = response.productSize?[index].image, img != Router.BASE_IMAGE_URL && img != "" {
            Utility.setImageWithSDWebImage(response.productSize?[index].image ?? "", self.imgProduct)
        } else {
            Utility.setImageWithSDWebImage("\(Router.BASE_IMAGE_URL)\(response.image ?? "")", self.imgProduct)
        }
        
        self.clvSize.reloadData()
        self.clvPriceGoDown.reloadData()
        self.tblIncludedItemPrice.reloadData()
        self.tblPriceWillUp.reloadData()
        self.tblChoose1.reloadData()
        self.tblChoose2.reloadData()
        self.tblChoose3.reloadData()
        self.tblChoose4.reloadData()
    }
    
    @IBAction func btnAdd(_ sender: UIButton) {
        self.qty = self.qty + 1
        self.lblQty.text = "\(self.qty)"
        self.calculationOfPrice()
    }
    
    @IBAction func btnMinus(_ sender: UIButton) {
        if self.qty > 1 {
            self.qty = self.qty - 1
            self.lblQty.text = "\(self.qty)"
            self.calculationOfPrice()
        }
    }
    
    func paramAddToCart() -> [String:AnyObject] {
        var dict : [String:AnyObject] = [:]
        dict["user_id"] = k.userDefault.value(forKey: k.session.userId) as AnyObject
        dict["product_id"] = self.productId as AnyObject
        dict["product_name"] = self.productName as AnyObject
        dict["total_amount"] = self.totalAmount as AnyObject
        dict["quantity"] = self.qty as AnyObject
        dict["size_price"] = self.sizePrice as AnyObject
        dict["size_name"] = self.sizeName as AnyObject
        dict["size_id"] = self.sizeId as AnyObject
        dict["extra_item_id"] = self.arrExtraItemId.joined(separator: ",") as AnyObject
        dict["extra_item_price"] = self.arrExtraItemPrice.joined(separator: ",") as AnyObject
        dict["extra_item_name"] = self.arrExtraItemName.joined(separator: ",") as AnyObject
        dict["extra_item_qty"] = self.arrExtraItemQty.joined(separator: ",") as AnyObject
        dict["total_extra_item_price"] = self.arrExtraItemQtyPrice.joined(separator: ",") as AnyObject
        dict["company_id"] = k.userDefault.value(forKey: k.session.interestedRestId) as AnyObject
        dict["cat_id"] = self.categoryId as AnyObject
        dict["cat_name"] = self.categoryName as AnyObject
        print(dict)
        return dict
    }
    
    func addToCart() {
        print(self.arrExtraItemId.joined(separator: ","))
        print(self.arrExtraItemName.joined(separator: ","))
        print(self.arrExtraItemPrice.joined(separator: ","))
        print(self.arrExtraItemQty.joined(separator: ","))
        print(self.arrExtraItemQtyPrice.joined(separator: ","))
        print(self.paramAddToCart())
        Api.shared.addCart(self, self.paramAddToCart()) { (response) in
            self.navigationController?.popViewController(animated: true)
//            Utility.showAlertWithAction(withTitle: "", message: R.string.localizable.itemAddedToCartSuccessfully(), delegate: nil, parentViewController: self) { (bool) in
               
//            }
        }
    }
    
    @IBAction func btnFav(_ sender: UIButton) {
        if Utility.isUserLogin() {
            self.addToFavourite()
        } else {
            Utility.showAlertRegistration(parentViewController: self) { (bool) in
                if bool {
                    Utility.logoutt()
                }
            }
        }
    }
    
    func addToFavourite() {
        Api.shared.tapToFavourite(self, self.paramTapFavourite()) { (response) in
            if let productLike = response.message, productLike == "unlike successfull" {
                self.btnFav.setImage(R.image.favoritenill(), for: .normal)
            } else {
                self.btnFav.setImage(R.image.favoritefill(), for: .normal)
            }
        }
    }
    
    func paramTapFavourite() -> [String:AnyObject] {
        var dict : [String:AnyObject] = [:]
        dict["user_id"] = k.userDefault.value(forKey: k.session.userId) as AnyObject
        dict["product_id"] = self.productId as AnyObject
        return dict
    }
    
    @IBAction func btnAddToCart(_ sender: UIButton) {
        if Utility.isUserLogin() {
            self.addToCartMain()
        } else {
            Utility.showAlertRegistration(parentViewController: self) { (bool) in
                if bool {
                    Utility.logoutt()
                }
            }
        }
    }
    
    func addToCartMain() {
        print(totalAmount)
        self.calcExtraItem()
        if self.singleChoose1 == true && self.singleChoose2 == true && self.singleChoose3 == true && self.singleChoose4 == true {
            if self.totalAmount == 0 {
                Utility.showAlertMessage(withTitle: k.appName, message: R.string.localizable.youNeedToSelectItemFromBelowList(), delegate: nil, parentViewController: self)
            } else {
                self.addToCart()
            }
        } else {
            Utility.showAlertWithAction(withTitle: k.appName, message: R.string.localizable.youNeedToSelectTheAnyOneItemFromAllSingleChoiceMenu(), delegate: nil, parentViewController: self) { (bool) in
                ""
            }
        }
    }
    
    func calcExtraItem() {
        self.arrExtraItemId = []
        self.arrExtraItemPrice = []
        self.arrExtraItemName = []
        self.arrExtraItemQty = []
        self.arrExtraItemQtyPrice = []
        var index1 = 0
        let cellsIncludedItemPrice = self.tblIncludedItemPrice.visibleCells as! Array<ProductCheckCell>
        for cell in cellsIncludedItemPrice {
            if cell.btnCheck.image(for: .normal) == R.image.check_box_fill_18pt() {
                self.arrExtraItemId.append(self.arrIncludeItemPrice[index1].id ?? "")
                self.arrExtraItemPrice.append(self.arrIncludeItemPrice[index1].itemPrice ?? "")
                self.arrExtraItemName.append(self.arrIncludeItemPrice[index1].itemName ?? "")
                self.arrExtraItemQty.append("1")
            }
            index1 = index1 + 1
        }
        
        var index7 = 0
        let cellsPriceGoDown = self.clvPriceGoDown.visibleCells as! Array<SizeCell>
        for cell in cellsPriceGoDown {
            print(index7)
            let indexPath = IndexPath(row: index7, section: 0)
            if self.arrPriceGoDown[indexPath.row].isConsiderInCal {
                self.arrExtraItemId.append(self.arrPriceGoDown[indexPath.row].arrPriceGoDown.id ?? "")
                self.arrExtraItemPrice.append(self.arrPriceGoDown[index7].arrPriceGoDown.itemPrice ?? "")
                self.arrExtraItemName.append(self.arrPriceGoDown[indexPath.row].arrPriceGoDown.itemName ?? "")
                print("Inside the if :\(indexPath.row)")
                print(self.arrPriceGoDown[indexPath.row].arrPriceGoDown.itemName ?? "")
                self.arrExtraItemQty.append("1")
            }
            index7 = index7 + 1
        }
        
        var index6 = 0
        let cellsPriceWillUp = self.tblPriceWillUp.visibleCells as! Array<ProductPlusMinusCell>
        for cell in cellsPriceWillUp {
            if cell.btnCheck.image(for: .normal) == R.image.check_box_fill_18pt() {
                self.arrExtraItemId.append(self.arrPriceWillUp[index6].arrPriceWillUp.id ?? "")
                self.arrExtraItemPrice.append(self.arrPriceWillUp[index6].arrPriceWillUp.itemPrice ?? "")
                self.arrExtraItemName.append("\(cell.lblQty.text!) x \(self.arrPriceWillUp[index6].arrPriceWillUp.itemName ?? "")")
                self.arrExtraItemQty.append(cell.lblQty.text!)
                
                var tot = 0.0
                if let price = self.arrPriceWillUp[index6].arrPriceWillUp.itemPrice, price != "" && price != "0.0" && price != "0" && price != "00" {
                    let updatedString = price.removingWhitespaces()
                    let fprice = Double(updatedString) ?? 0.0
                    let fqty = Double(cell.lblQty.text!) ?? 0.0
                    tot = fprice * fqty
                }
                arrExtraItemQtyPrice.append(String(tot))
            }
            index6 = index6 + 1
        }
        
        var index2 = 0
        let cellChoose1 = self.tblChoose1.visibleCells as! Array<ProductRadioCell>
        for cell in cellChoose1 {
            if cell.btnCheck.image(for: .normal) == R.image.radio_check() {
                self.arrExtraItemId.append(self.arrChoose1[index2].arrChoose1.id ?? "")
                self.arrExtraItemPrice.append(self.arrChoose1[index2].arrChoose1.itemPrice ?? "")
                self.arrExtraItemName.append(self.arrChoose1[index2].arrChoose1.itemName ?? "")
                self.arrExtraItemQty.append("1")
            }
            index2 = index2 + 1
        }
        
        var index3 = 0
        let cellChoose2 = self.tblChoose2.visibleCells as! Array<ProductRadioCell>
        for cell in cellChoose2 {
            if cell.btnCheck.image(for: .normal) == R.image.radio_check() {
                self.arrExtraItemId.append(self.arrChoose2[index3].arrChoose2.id ?? "")
                self.arrExtraItemPrice.append(self.arrChoose2[index3].arrChoose2.itemPrice ?? "")
                self.arrExtraItemName.append(self.arrChoose2[index3].arrChoose2.itemName ?? "")
                self.arrExtraItemQty.append("1")
            }
            index3 = index3 + 1
        }
        
        var index4 = 0
        let cellChoose3 = self.tblChoose3.visibleCells as! Array<ProductRadioCell>
        for cell in cellChoose3 {
            if cell.btnCheck.image(for: .normal) == R.image.radio_check() {
                self.arrExtraItemId.append(self.arrChoose3[index4].arrChoose3.id ?? "")
                self.arrExtraItemPrice.append(self.arrChoose3[index4].arrChoose3.itemPrice ?? "")
                self.arrExtraItemName.append(self.arrChoose3[index4].arrChoose3.itemName ?? "")
                self.arrExtraItemQty.append("1")
            }
            index4 = index4 + 1
        }
        
        var index5 = 0
        let cellChoose4 = self.tblChoose4.visibleCells as! Array<ProductRadioCell>
        for cell in cellChoose4 {
            if cell.btnCheck.image(for: .normal) == R.image.radio_check() {
                self.arrExtraItemId.append(self.arrChoose4[index5].arrChoose4.id ?? "")
                self.arrExtraItemPrice.append(self.arrChoose4[index5].arrChoose4.itemPrice ?? "")
                self.arrExtraItemName.append(self.arrChoose4[index5].arrChoose4.itemName ?? "")
                self.arrExtraItemQty.append("1")
            }
            index5 = index5 + 1
        }
    }
    
    @IBAction func btnExtraItemOpen(_ sender: UIButton) {
        if self.btnExtraItem.image(for: .normal) == R.image.downarrow() {
            self.btnExtraItem.setImage(R.image.uparrow(), for: .normal)
            self.vwPriceWillUp.isHidden = false
        } else {
            self.btnExtraItem.setImage(R.image.downarrow(), for: .normal)
            self.vwPriceWillUp.isHidden = true
        }
    }
    
    @IBAction func btn(_ sender: UIButton) {
        print("sdfsdfasdfasdfads")
    }
}

extension ProductDetailVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.clvSize {
            return self.arrSize.count
        } else {
            return self.arrPriceGoDown.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.clvSize {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.sizeCell, for: indexPath)!
            let obj = self.arrSize[indexPath.row]
            cell.lbl.text = self.arrSize[indexPath.row].arrSize.size ?? ""
            cell.vw.backgroundColor = .systemGroupedBackground
            cell.lbl.textColor = .black
            if obj.isSelected {
                cell.vw.backgroundColor = R.color.theme_color()
                self.sizeId = obj.arrSize.id ?? ""
                self.sizeName = obj.arrSize.size ?? ""
                self.sizePrice = obj.arrSize.price ?? ""
            }
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.sizeCell, for: indexPath)!
            let obj = self.arrPriceGoDown[indexPath.row]
            if let price = obj.arrPriceGoDown.itemPrice, price != "" && price != "0.0" && price != "0" && price != "00" {
                cell.lbl.text = "\(obj.arrPriceGoDown.itemName ?? "") \(price) \(k.currency)"
            } else {
                cell.lbl.text = obj.arrPriceGoDown.itemName ?? ""
            }
            if self.arrPriceGoDown[indexPath.row].isSelected {
                cell.vw.backgroundColor = hexStringToUIColor(hex: "#1E8F12")
                cell.lbl.textColor = .white
            } else {
                cell.vw.backgroundColor = .lightGray
                cell.lbl.textColor = .black
            }
            return cell
        }
    }
}

extension ProductDetailVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.clvSize {
            return CGSize(width: 125, height: 50)
        } else {
            return CGSize(width: self.clvPriceGoDown.frame.width / 2, height: 50)
        }
    }
}

extension ProductDetailVC: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.clvSize {
            let cell = collectionView.cellForItem(at: indexPath) as! SizeCell
            cell.vw.backgroundColor = R.color.theme_color()
            let obj = self.arrSize[indexPath.row]
            self.sizeId = obj.arrSize.id ?? ""
            self.sizeName = obj.arrSize.size ?? ""
            self.sizePrice = obj.arrSize.price ?? ""
            
            for (index,_) in self.arrSize.enumerated() {
                if index == indexPath.row {
                    self.arrSize[index].isSelected = true
                } else {
                    self.arrSize[index].isSelected = false
                }
            }
            self.clvSize.reloadData()
            if let res = self.mainResponse {
                self.changeSize(indexPath.row, res)
                self.calculationOfPrice()
            }
        } else {
            self.arrPriceGoDown[indexPath.row].isSelected = !self.arrPriceGoDown[indexPath.row].isSelected
            self.arrPriceGoDown[indexPath.row].isConsiderInCal = true
            self.clvPriceGoDown.reloadData()
        }
        self.calculationOfPrice()
    }
}

extension ProductDetailVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.tblPriceWillUp {
            return self.arrPriceWillUp.count
        } else if tableView == self.tblIncludedItemPrice {
            return self.arrIncludeItemPrice.count
        } else if tableView == self.tblChoose1 {
            return self.arrChoose1.count
        } else if tableView == self.tblChoose2 {
            return self.arrChoose2.count
        } else if tableView == self.tblChoose3 {
            return self.arrChoose3.count
        } else {
            return self.arrChoose4.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == self.tblPriceWillUp {
            let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.productPlusMinusCell, for: indexPath)!
            cell.lblItemName.text = self.arrPriceWillUp[indexPath.row].arrPriceWillUp.itemName ?? ""
            if let price = self.arrPriceWillUp[indexPath.row].arrPriceWillUp.itemPrice, price != "" && price != "0.0" && price != "0" && price != "00" {
                cell.lblPrice.text = "\(k.currency)\(self.arrPriceWillUp[indexPath.row].arrPriceWillUp.itemPrice ?? "")"
            } else {
                cell.lblPrice.text = ""
            }
            cell.btnCheck.setImage(R.image.check_box_nill_18pt(), for: .normal)
            cell.cloCheck = {(isCheck) in
                if isCheck {
                    self.arrPriceWillUp[indexPath.row].isSelected = true
                } else {
                    self.arrPriceWillUp[indexPath.row].isSelected = false
                }
                self.calculationOfPrice()
            }
            
            cell.cloUpdate = {(isCheck, isPlus, qty) in
                self.arrPriceWillUp[indexPath.row].qty = qty
                self.calculationOfPrice()
            }
            return cell
        } else if tableView == self.tblIncludedItemPrice {
            let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.productCheckCell, for: indexPath)!
            cell.lblItemName.text = self.arrIncludeItemPrice[indexPath.row].itemName ?? ""
            if let price = self.arrIncludeItemPrice[indexPath.row].itemPrice, price != "" && price != "0.0" && price != "0" && price != "00" {
                cell.lblPrice.text = "\(k.currency)\(self.arrIncludeItemPrice[indexPath.row].itemPrice ?? "")"
            } else {
                cell.lblPrice.text = ""
            }
            return cell
        } else if tableView == self.tblChoose1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.productRadioCell, for: indexPath)!
            cell.lblItemName.text = self.arrChoose1[indexPath.row].arrChoose1.itemName ?? ""
            if let price = self.arrChoose1[indexPath.row].arrChoose1.itemPrice, price != "" && price != "0.0" && price != "0" && price != "00" {
                cell.lblPrice.text = "\(k.currency)\(self.arrChoose1[indexPath.row].arrChoose1.itemPrice ?? "")"
            } else {
                cell.lblPrice.text = ""
            }
            print(self.arrChoose1[indexPath.row])
            if self.arrChoose1[indexPath.row].isSelected {
                cell.btnCheck.setImage(R.image.radio_check(), for: .normal)
            } else {
                cell.btnCheck.setImage(R.image.radio_uncheck(), for: .normal)
            }
            
            cell.cloCheck = {() in
                for (index,_) in self.arrChoose1.enumerated() {
                    if index == indexPath.row {
                        self.arrChoose1[index].isSelected = true
                    } else {
                        self.arrChoose1[index].isSelected = false
                    }
                }
                self.singleChoose1 = true
                self.tblChoose1.reloadData()
                self.calculationOfPrice()
            }
            return cell
        } else if tableView == self.tblChoose2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.productRadioCell, for: indexPath)!
            cell.lblItemName.text = self.arrChoose2[indexPath.row].arrChoose2.itemName ?? ""
            if let price = self.arrChoose2[indexPath.row].arrChoose2.itemPrice, price != "" && price != "0.0" && price != "0" && price != "00" {
                cell.lblPrice.text = "\(k.currency)\(self.arrChoose2[indexPath.row].arrChoose2.itemPrice ?? "")"
            } else {
                cell.lblPrice.text = ""
            }
            
            if self.arrChoose2[indexPath.row].isSelected {
                cell.btnCheck.setImage(R.image.radio_check(), for: .normal)
            } else {
                cell.btnCheck.setImage(R.image.radio_uncheck(), for: .normal)
            }
            
            cell.cloCheck = {() in
                for (index,_) in self.arrChoose2.enumerated() {
                    if index == indexPath.row {
                        self.arrChoose2[index].isSelected = true
                    } else {
                        self.arrChoose2[index].isSelected = false
                    }
                }
                self.singleChoose2 = true
                self.tblChoose2.reloadData()
                self.calculationOfPrice()
            }
            return cell
        } else if tableView == self.tblChoose3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.productRadioCell, for: indexPath)!
            cell.lblItemName.text = self.arrChoose3[indexPath.row].arrChoose3.itemName ?? ""
            if let price = self.arrChoose3[indexPath.row].arrChoose3.itemPrice, price != "" && price != "0.0" && price != "0" && price != "00" {
                cell.lblPrice.text = "\(k.currency)\(self.arrChoose3[indexPath.row].arrChoose3.itemPrice ?? "")"
            } else {
                cell.lblPrice.text = ""
            }
            if self.arrChoose3[indexPath.row].isSelected {
                cell.btnCheck.setImage(R.image.radio_check(), for: .normal)
            } else {
                cell.btnCheck.setImage(R.image.radio_uncheck(), for: .normal)
            }
            
            cell.cloCheck = {() in
                for (index,_) in self.arrChoose3.enumerated() {
                    if index == indexPath.row {
                        self.arrChoose3[index].isSelected = true
                    } else {
                        self.arrChoose3[index].isSelected = false
                    }
                }
                self.singleChoose3 = true
                self.tblChoose3.reloadData()
                self.calculationOfPrice()
            }
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.productRadioCell, for: indexPath)!
            cell.lblItemName.text = self.arrChoose4[indexPath.row].arrChoose4.itemName ?? ""
            if let price = self.arrChoose4[indexPath.row].arrChoose4.itemPrice, price != "" && price != "0.0" && price != "0" && price != "00" {
                cell.lblPrice.text = "\(k.currency)\(self.arrChoose4[indexPath.row].arrChoose4.itemPrice ?? "")"
            } else {
                cell.lblPrice.text = ""
            }
            if self.arrChoose4[indexPath.row].isSelected {
                cell.btnCheck.setImage(R.image.radio_check(), for: .normal)
            } else {
                cell.btnCheck.setImage(R.image.radio_uncheck(), for: .normal)
            }
            
            cell.cloCheck = {() in
                for (index,_) in self.arrChoose4.enumerated() {
                    if index == indexPath.row {
                        self.arrChoose4[index].isSelected = true
                    } else {
                        self.arrChoose4[index].isSelected = false
                    }
                }
                self.singleChoose4 = true
                self.tblChoose4.reloadData()
                self.calculationOfPrice()
            }
            return cell
        }
    }
}

extension ProductDetailVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
}
//
//var arrSize: [ResProductSize] = []
//var arrPriceGoDown: [ResProductAdditional] = []
//var arrIncludeItemPrice: [ResProductAdditional] = []
//var arrPriceWillUp: [ResProductAdditional] = []
//var arrChoose1: [ResProductAdditional] = []
//var arrChoose2: [ResProductAdditional] = []
//var arrChoose3: [ResProductAdditional] = []
//var arrChoose4: [ResProductAdditional] = []

struct myArrSize {
    var arrSize:ResProductSize
    var isSelected: Bool
}

struct myArrPriceGoDown {
    var arrPriceGoDown: ResProductAdditional
    var isSelected: Bool
    var isConsiderInCal: Bool
}

struct myArrPriceWillUp {
    
    var arrPriceWillUp: ResProductAdditional
    var isSelected: Bool
    var qty: Int
}

struct myArrChoose1 {
    
    var arrChoose1: ResProductAdditional
    var isSelected: Bool
    var qty: Int
}

struct myArrChoose2 {
    
    var arrChoose2: ResProductAdditional
    var isSelected: Bool
    var qty: Int
}

struct myArrChoose3 {
    
    var arrChoose3: ResProductAdditional
    var isSelected: Bool
    var qty: Int
}

struct myArrChoose4 {
    
    var arrChoose4: ResProductAdditional
    var isSelected: Bool
    var qty: Int
}
