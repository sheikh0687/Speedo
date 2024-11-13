//
//  HomeVC.swift
//  Speedo
//
//  Created by mac on 18/04/21.
//

import UIKit

class HomeVC: UIViewController {

    @IBOutlet weak var clvBanner: UICollectionView!
    @IBOutlet weak var clvTopRated: UICollectionView!
    @IBOutlet weak var clvCategory: UICollectionView!
    @IBOutlet weak var constCateHeight: NSLayoutConstraint!
    @IBOutlet weak var PageControl: UIPageControl!
    @IBOutlet weak var lblTotalCart: UILabel!
    @IBOutlet weak var lblTotalCount: UILabel!
    @IBOutlet weak var vwCart: UIView!
    
    var idenBanner = "BannerCell"
    var idenTopRated = "TopRatedCell"
    var idenCategory = "CategoryCell"
    
    var arrBanner:[ResRestOfferList] = []
    var arrCategory:[ResCategory] = []
    var arrTopRestaurant:[ResRestaurant] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.clvBanner.register(UINib(nibName: idenBanner, bundle: nil), forCellWithReuseIdentifier: idenBanner)
        self.clvTopRated.register(UINib(nibName: idenTopRated, bundle: nil), forCellWithReuseIdentifier: idenTopRated)
        self.clvCategory.register(UINib(nibName: idenCategory, bundle: nil), forCellWithReuseIdentifier: idenCategory)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBarItem(LeftTitle: "", LeftImage: "menu", CenterTitle: "Speedybondos", CenterImage: "", RightTitle: "", RightImage: "noti", BackgroundColor: k.themeColor, BackgroundImage: "", TextColor: "#FFFFFF", TintColor: "#FFFFFF", Menu: "")
        self.getBannerList()
        self.getCategoryList()
        self.getTopRestaurant()
        print(k.userDefault.value(forKey: k.session.userLogin))
        if Utility.isUserLogin() {
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
    
    func getBannerList() {
        Api.shared.getRestOfferList(self, self.paramCommon()) { (response) in
            if response.count > 0 {
                self.arrBanner = response
                self.PageControl.numberOfPages = response.count
            } else {
                self.arrBanner = []
                self.PageControl.numberOfPages = 0
            }
            self.clvBanner.reloadData()
        }
    }
    
    func paramCommon() -> [String:AnyObject] {
        var dict : [String:AnyObject] = [:]
        dict["rest_id"] = k.userDefault.value(forKey: k.session.interestedRestId) as AnyObject
        return dict
    }
    
    func paramTopRestaurant() -> [String:AnyObject] {
        var dict : [String:AnyObject] = [:]
        if Utility.isUserLogin() {
            dict["user_id"] = k.userDefault.value(forKey: k.session.userId) as AnyObject
        } else {
            dict["user_id"] = "" as AnyObject
        }
        dict["rest_id"] = k.userDefault.value(forKey: k.session.interestedRestId) as AnyObject
        dict["timezone"] = localTimeZoneIdentifier as AnyObject
        dict["size"] = k.emptyString as AnyObject
        dict["now_current_day"] = Utility.getCurrentDay() as AnyObject
        return dict
    }
    
    func getTopRestaurant() {
        print(self.paramTopRestaurant())
        Api.shared.getTopRestaurantList(self, self.paramTopRestaurant()) { (response) in
            if response.count > 0 {
                self.arrTopRestaurant = response
                globalDeliveryOption = response[0].deliveryOption ?? ""
            } else {
                self.arrTopRestaurant = []
                globalDeliveryOption = ""
            }
            self.clvTopRated.reloadData()
        }
    }
    
    func getCategoryList() {
        print(self.paramCommon())
        Api.shared.getCategoryList(self, self.paramCommon()) { (response) in
            if response.count > 0 {
                self.arrCategory = response
                if response.count % 2 == 0 {
                    self.constCateHeight.constant = CGFloat((125 * (response.count/2)))
                } else {
                    self.constCateHeight.constant = CGFloat((125 * (response.count/2)) + 125)
                }
            } else {
                self.arrCategory = []
            }
            self.clvCategory.reloadData()
        }
    }
    
    @IBAction func btnSeeMore(_ sender: UIButton) {
        let vc = R.storyboard.main().instantiateViewController(withIdentifier: "TopRatedRestVC") as! TopRatedRestVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func rightClick() {
        let vc = R.storyboard.main().instantiateViewController(withIdentifier: "ResNotificationVC") as! ResNotificationVC
        vc.comingFrom = "user"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnCart(_ sender: UIButton) {
        let vc = R.storyboard.main().instantiateViewController(withIdentifier: "CartVC") as! CartVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension HomeVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.clvBanner {
            return self.arrBanner.count
        } else if collectionView == self.clvTopRated {
            return self.arrTopRestaurant.count
        } else {
            return self.arrCategory.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.clvBanner {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.bannerCell, for: indexPath)!
            let obj = self.arrBanner[indexPath.row]
            Utility.setImageWithSDWebImage(self.arrBanner[indexPath.row].image ?? "", cell.img)
            cell.lblTitle.text = "\(obj.title ?? "") (\(R.string.localizable.useCode()) \(obj.offerCode ?? ""))"
            cell.lblDesc.text = obj.descriptionField ?? ""
            cell.lblExpDate.text = "\(R.string.localizable.theOfferIsValidFrom()) \(obj.startTime ?? "") \(R.string.localizable.to()) \(obj.endTime ?? "")"
            cell.lblDate.text = "\(R.string.localizable.expireOn()) \(obj.expDate ?? "")"
            return cell
        } else if collectionView == self.clvTopRated {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.topRatedCell, for: indexPath)!
            let obj = self.arrTopRestaurant[indexPath.row]
            cell.lblRestName.text = obj.restName ?? ""
            Utility.setImageWithSDWebImage(obj.restCoverImage ?? "", cell.imgRest)
            Utility.setImageWithSDWebImage(obj.restImage ?? "", cell.imgDish)
            cell.lblStatus.text = obj.restOpenStatus ?? ""
            if let status = obj.restOpenStatus, status == "CLOSE" {
                cell.lblStatus.backgroundColor = .red
            }
            cell.lblSpeciality.text = obj.aboutMe ?? ""
            cell.vwRating.rating = Double(obj.avgRating ?? "") ?? 0.0
            cell.vwRating.text = "(\(obj.totalRatingCount ?? ""))"
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.categoryCell, for: indexPath)!
            let obj = self.arrCategory[indexPath.row]
            cell.lbl.text = obj.categoryName ?? ""
            Utility.setImageWithSDWebImage(obj.image ?? "", cell.img)
            return cell
        }
    }
}

extension HomeVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.clvBanner {
            return CGSize(width: self.clvBanner.frame.width, height: 280)
        } else if collectionView == self.clvTopRated {
            return CGSize(width: self.view.bounds.width - 10, height: 260)
        } else {
            return CGSize(width: self.clvBanner.frame.width / 2, height: 125)
        }
    }
}

extension HomeVC: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.clvCategory {
            let vc = R.storyboard.main().instantiateViewController(withIdentifier: "ProductVC") as! ProductVC
            vc.categoryId = self.arrCategory[indexPath.row].id ?? ""
            self.navigationController?.pushViewController(vc, animated: true)
        } else if collectionView == self.clvTopRated {
            let vc = R.storyboard.main().instantiateViewController(withIdentifier: "RestaurantMenuVC") as! RestaurantMenuVC
            vc.objRest = self.arrTopRestaurant[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
        } else if collectionView == self.clvBanner {
            let vc = R.storyboard.main().instantiateViewController(withIdentifier: "ProductVC") as! ProductVC
            vc.categoryId = self.arrBanner[indexPath.row].catId ?? ""
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if collectionView == self.clvBanner {
            self.PageControl.currentPage = indexPath.row
        }
    }
}
